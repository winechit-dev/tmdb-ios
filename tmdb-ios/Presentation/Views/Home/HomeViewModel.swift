//
//  HomeViewModel.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var trendingTodayMovies: [MovieModel] = []
    @Published var popularMovies: [MovieModel] = []
    @Published var upcomingMovies: [MovieModel] = []
    @Published var nowPlayingMovies: [MovieModel] = []
    @Published var topRatedMovies: [MovieModel] = []
    
    private let repository: MovieRepository = MovieRepository()
    
    init(){
        Task{
            await fetchAllMovies()
        }
    }
    
    @MainActor
    func fetchAllMovies() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchMovies(type: .trendingToday) }
            group.addTask { await self.fetchMovies(type: .popular) }
            group.addTask { await self.fetchMovies(type: .upcoming) }
            group.addTask { await self.fetchMovies(type: .topRated) }
            group.addTask { await self.fetchMovies(type: .nowPlaying) }
        }
    }
    
    enum MovieType {
        case trendingToday, popular, upcoming, topRated, nowPlaying
    }
    
    @MainActor
    private func fetchMovies(type: MovieType) async {
        do {
            let response = try await fetchMovieData(for: type)
            updateMovieList(type: type, movies: response)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func fetchMovieData(for type: MovieType) async throws -> [MovieModel] {
        switch type {
        case .trendingToday: return try await repository.getTrendingTodayMovies()
        case .popular: return try await repository.getPopularMovies()
        case .upcoming: return try await repository.getUpcomingMovies()
        case .topRated: return try await repository.getTopRatedMovies()
        case .nowPlaying: return try await repository.getNowPlayingMovies()
        }
    }
    
    private func updateMovieList(type: MovieType, movies: [MovieModel]) {
        switch type {
        case .trendingToday: trendingTodayMovies = movies
        case .popular: popularMovies = movies
        case .upcoming: upcomingMovies = movies
        case .topRated: topRatedMovies = movies
        case .nowPlaying: nowPlayingMovies = movies
        }
    }
}

//
//  HomeViewModel.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var uiState = HomeUIState()
    private var oldUiState = HomeUIState()
    
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
            uiState.errorMessage = error.localizedDescription
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
        case .trendingToday: uiState.trendingTodayMovies = movies
        case .popular: uiState.popularMovies = movies
        case .upcoming: uiState.upcomingMovies = movies
        case .topRated: uiState.topRatedMovies = movies
        case .nowPlaying: uiState.nowPlayingMovies = movies
        }
        oldUiState = uiState
    }
    
    func searchMovies(searchText: String) {
        guard !searchText.isEmpty else {
            uiState = oldUiState
            return
        }
        uiState.trendingTodayMovies = filterMovies(uiState.trendingTodayMovies,searchText: searchText)
        uiState.popularMovies = filterMovies(uiState.popularMovies,searchText: searchText)
        uiState.upcomingMovies = filterMovies(uiState.upcomingMovies,searchText: searchText)
        uiState.nowPlayingMovies = filterMovies(uiState.nowPlayingMovies,searchText: searchText)
        uiState.topRatedMovies = filterMovies(uiState.topRatedMovies,searchText: searchText)
    }
    
    private func filterMovies(_ movies: [MovieModel],searchText: String) -> [MovieModel] {
           guard !searchText.isEmpty else { return movies }
           return movies.filter { movie in
               movie.title.localizedCaseInsensitiveContains(searchText)
           }
    }
}

struct HomeUIState {
    var errorMessage: String = ""
    var trendingTodayMovies: [MovieModel] = []
    var popularMovies: [MovieModel] = []
    var upcomingMovies: [MovieModel] = []
    var nowPlayingMovies: [MovieModel] = []
    var topRatedMovies: [MovieModel] = []
}

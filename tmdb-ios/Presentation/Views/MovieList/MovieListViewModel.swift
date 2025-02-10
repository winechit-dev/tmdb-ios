//
//  MovieListViewModel.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 6/2/2568 BE.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var uiState = MovieListUIState()
    private let repository: MovieRepository = MovieRepository()
    
    init(type: MovieType) {
        Task{
            await fetchMovies(type: type)
        }
    }
    
    @MainActor
    private func fetchMovies(type: MovieType) async {
        do {
            let response = try await fetchMovieData(for: type)
            uiState.movies = response
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
}

struct MovieListUIState {
    var errorMessage: String = ""
    var movies: [MovieModel] = []
}

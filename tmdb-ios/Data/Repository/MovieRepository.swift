//
//  MovieRepository.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//

import Combine

protocol MovieRepositoryProvider {
    func getTrendingTodayMovies() async throws -> [MovieModel]
    func getPopularMovies() async throws -> [MovieModel]
    func getUpcomingMovies() async throws -> [MovieModel]
    func getTopRatedMovies() async throws -> [MovieModel]
    func getNowPlayingMovies() async throws -> [MovieModel]
}

class MovieRepository : MovieRepositoryProvider {
    private let apiService: ApiService
    
    init() {
        self.apiService = ApiService()
    }
    
    func getTrendingTodayMovies() async throws -> [MovieModel] {
        let response = try await self.apiService.getData(
            type: MoviesResponse.self,
            endpoint: "/trending/movie/day"
        )
        
        return response.results.map { $0.toMovieModel() }
    }
    
    func getPopularMovies() async throws -> [MovieModel] {
        let response = try await self.apiService.getData(
            type: MoviesResponse.self,
            endpoint: "/movie/popular"
        )
        
        return response.results.map { $0.toMovieModel() }
    }
    
    func getUpcomingMovies() async throws -> [MovieModel] {
        let response = try await self.apiService.getData(
            type: MoviesResponse.self,
            endpoint: "/movie/upcoming"
        )
        
        return response.results.map { $0.toMovieModel() }
    }
    
    func getTopRatedMovies() async throws -> [MovieModel] {
        let response = try await self.apiService.getData(
            type: MoviesResponse.self,
            endpoint: "/movie/top_rated"
        )
        
        return response.results.map { $0.toMovieModel() }
    }
    
    func getNowPlayingMovies() async throws -> [MovieModel] {
        let response = try await self.apiService.getData(
            type: MoviesResponse.self,
            endpoint: "/movie/now_playing"
        )
        
        return response.results.map { $0.toMovieModel() }
    }
}


enum GeneralError : Error {
    case generalError(message : String)
}

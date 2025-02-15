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
    func getMovieDetails(movieId: Int) async throws -> MovieDetailsModel
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
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetailsModel {
        let response = try await self.apiService.getData(
            type: MovieDetailsResponse.self,
            endpoint: "/movie/\(movieId)"
        )
        
        let cast = try await self.apiService.getCredits(
            type: CreditsResponse.self,
            endpoint: "/movie/\(movieId)/credits"
        ).cast

        let recommendations = try await self.apiService.getData(
            type: MoviesResponse.self,
            endpoint: "/movie/\(movieId)/recommendations"
        ).results
        
        return response.toMovieDetailsModel(cast: cast, recommendations: recommendations)
    }
}


enum GeneralError : Error {
    case generalError(message : String)
}

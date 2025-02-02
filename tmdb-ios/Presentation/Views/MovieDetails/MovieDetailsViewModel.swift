//
//  MovieDetailsViewModel.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


import SwiftUI
import Combine

class MovieDetailsViewModel: ObservableObject {
    @Published var uiState = MovieDetailsUIState()
    
    private let repository: MovieRepository = MovieRepository()
    
    init(movieId: Int){
        getDetails(movieId: movieId)
    }
    
    func getDetails(movieId:Int) {
        Task { @MainActor in
            do {
                uiState = MovieDetailsUIState()
                let details = try await repository.getMovieDetails(movieId:movieId)
                uiState.loading = false
                uiState.details = details
            } catch {
                uiState.errorMessage = error.localizedDescription
                uiState.loading = false
            }
        }
    }
}

struct MovieDetailsUIState {
    var loading: Bool = true
    var favorite: Bool = false
    var errorMessage : String = ""
    var details: MovieDetailsModel? = nil
}

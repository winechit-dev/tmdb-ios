//
//  FavoriteMovie.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 2/2/2568 BE.
//

import Foundation
import SwiftData

@Model
class FavoriteMovie{
    var id: UUID = UUID()
    var movieId: Int
    var posterPath : String
    var originalTitle : String
    
    init(movieId: Int, posterPath: String, originalTitle: String) {
        self.movieId = movieId
        self.posterPath = posterPath
        self.originalTitle = originalTitle
    }
}

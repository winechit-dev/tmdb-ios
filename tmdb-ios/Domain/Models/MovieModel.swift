//
//  MovieModel.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


import Foundation

struct MovieModel: Identifiable {
    let id: Int
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

extension MovieResponse {
    func toMovieModel() -> MovieModel {
        return MovieModel(
            id: id,
            adult: adult,
            backdropPath: backdropPath ?? "",
            genreIds: genreIds,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath.createImageUrl(),
            releaseDate: releaseDate.changeFormat(from: "yyyy-MM-dd", to: "dd MMM yyyy"),
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
    }
}

extension String {
    func changeFormat(from originPattern: String, to targetPattern: String, defaultValue: String = "-") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = originPattern
        
        guard let date = dateFormatter.date(from: self) else { return self }
        
        dateFormatter.dateFormat = targetPattern
        return dateFormatter.string(from: date)
    }
}

extension Optional where Wrapped == String {
    func createImageUrl() -> String {
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        return "\(baseURL)/\(self ?? "")"
    }
}




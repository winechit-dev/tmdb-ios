//
//  MovieDetailsResponse.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


struct MovieDetailsResponse: Codable {
   let adult: Bool?
   let backdropPath: String?
   let budget: Int?
   let genres: [GenreResponse]?
   let homepage: String?
   let id: Int?
   let imdbId: String?
   let originalLanguage: String?
   let originalTitle: String?
   let overview: String?
   let popularity: Double?
   let posterPath: String?
   let releaseDate: String?
   let revenue: Int?
   let runtime: Int?
   let status: String?
   let tagline: String?
   let title: String?
   let video: Bool?
   let voteAverage: Double?
   let voteCount: Int?
   
   enum CodingKeys: String, CodingKey {
       case adult
       case backdropPath = "backdrop_path"
       case budget
       case genres
       case homepage
       case id
       case imdbId = "imdb_id"
       case originalLanguage = "original_language"
       case originalTitle = "original_title"
       case overview
       case popularity
       case posterPath = "poster_path"
       case releaseDate = "release_date"
       case revenue
       case runtime
       case status
       case tagline
       case title
       case video
       case voteAverage = "vote_average"
       case voteCount = "vote_count"
   }
}

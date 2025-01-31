//
//  MovieDetailsModel.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


struct MovieDetailsModel {
   let adult: Bool
   let backdropPath: String
   let budget: Int
   let genres: [GenreModel]
   let homepage: String
   let id: Int
   let imdbId: String
   let originalLanguage: String
   let originalTitle: String
   let overview: String
   let popularity: Double
   let posterPath: String
   let releaseDate: String
   let revenue: Int
   let runtime: Int
   let status: String
   let tagline: String
   let title: String
   let video: Bool
   let voteAverage: Float
   let voteCount: Int
   let cast: [CastModel]
   let recommendations: [MovieModel]
   
   init(
       adult: Bool,
       backdropPath: String,
       budget: Int,
       genres: [GenreModel],
       homepage: String,
       id: Int,
       imdbId: String,
       originalLanguage: String,
       originalTitle: String,
       overview: String,
       popularity: Double,
       posterPath: String,
       releaseDate: String,
       revenue: Int,
       runtime: Int,
       status: String,
       tagline: String,
       title: String,
       video: Bool,
       voteAverage: Float,
       voteCount: Int,
       cast: [CastModel] = [],
       recommendations: [MovieModel] = []
   ) {
       self.adult = adult
       self.backdropPath = backdropPath
       self.budget = budget
       self.genres = genres
       self.homepage = homepage
       self.id = id
       self.imdbId = imdbId
       self.originalLanguage = originalLanguage
       self.originalTitle = originalTitle
       self.overview = overview
       self.popularity = popularity
       self.posterPath = posterPath
       self.releaseDate = releaseDate
       self.revenue = revenue
       self.runtime = runtime
       self.status = status
       self.tagline = tagline
       self.title = title
       self.video = video
       self.voteAverage = voteAverage
       self.voteCount = voteCount
       self.cast = cast
       self.recommendations = recommendations
   }
}


extension MovieDetailsResponse {
   func toMovieDetailsModel(
       cast: [CastResponse],
       recommendations: [MovieResponse]
   ) -> MovieDetailsModel {
       return MovieDetailsModel(
           adult: adult ?? false,
           backdropPath: backdropPath ?? "",
           budget: budget ?? 0,
           genres: genres?.map {
               GenreModel(
                   id: $0.id,
                   name: $0.name
               )
           } ?? [],
           homepage: homepage ?? "",
           id: id ?? 0,
           imdbId: imdbId ?? "",
           originalLanguage: originalLanguage ?? "",
           originalTitle: originalTitle ?? "",
           overview: overview ?? "",
           popularity: popularity ?? 0.0,
           posterPath: posterPath.createImageUrl(),
           releaseDate: releaseDate?.changeFormat(from: "yyyy-MM-dd", to: "dd MMM yyyy") ?? "",
           revenue: revenue ?? 0,
           runtime: runtime ?? 0,
           status: status ?? "",
           tagline: tagline ?? "",
           title: title ?? "",
           video: video ?? false,
           voteAverage: Float(voteAverage ?? 0.0),
           voteCount: voteCount ?? 0,
           cast: cast.toCast(),
           recommendations: recommendations.map { $0.toMovieModel() }
       )
   }
}

extension Array where Element == CastResponse {
    func toCast() -> [CastModel] {
        return self.map {
            CastModel(
                castId: $0.castId,
                id: $0.id,
                originalName: $0.originalName,
                profilePath: $0.profilePath.createImageUrl()
            )
        }
    }
}

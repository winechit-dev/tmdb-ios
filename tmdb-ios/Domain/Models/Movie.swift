//
//  MovieModel.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 28/1/2568 BE.
//

import Foundation

public struct Movie: Identifiable, Codable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    
    public init(id: Int, title: String, overview: String, posterPath: String?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
    }
}



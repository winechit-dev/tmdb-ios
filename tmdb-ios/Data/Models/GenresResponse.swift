//
//  GenresResponse.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


struct GenresResponse: Codable {
   let genres: [GenreResponse]
}

struct GenreResponse: Codable {
   let id: Int
   let name: String
   
   enum CodingKeys: String, CodingKey {
       case id
       case name
   }
}
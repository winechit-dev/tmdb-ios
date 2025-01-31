//
//  CastResponse.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


struct CastResponse: Codable {
   let adult: Bool
   let castId: Int
   let character: String
   let creditId: String
   let gender: Int
   let id: Int
   let knownForDepartment: String
   let name: String
   let order: Int
   let originalName: String
   let popularity: Double
   let profilePath: String?
   
   enum CodingKeys: String, CodingKey {
       case adult
       case castId = "cast_id"
       case character
       case creditId = "credit_id"
       case gender
       case id
       case knownForDepartment = "known_for_department"
       case name
       case order
       case originalName = "original_name"
       case popularity
       case profilePath = "profile_path"
   }
}
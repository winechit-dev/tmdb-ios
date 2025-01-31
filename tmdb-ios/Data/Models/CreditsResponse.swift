//
//  CreditsResponse.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


import Foundation

struct CreditsResponse: Codable {
    let cast: [CastResponse]
    let id: Int
}


//
//  ApiService.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//

import Foundation
import KeychainSwift

enum AppError: Error {
    case invalidURL
}

struct ApiService {
    let keychain = KeychainSwift()
    let language = "en-US"
    let baseUrl = "https://api.themoviedb.org/3"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
        keychain.set("431684f2f57b4a3f0d520afae0ee6a4f", forKey: "apiKey")
    }
    
    func postRequest<T: Decodable>(type: T.Type, urlString: String, request: Encodable) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw AppError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(request)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response)  =  try await session.data(for: urlRequest)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func getData<T: Decodable>(type: T.Type, endpoint: String) async throws -> T {
        let apiKey = keychain.get("apiKey") ?? ""
        let fullURLString = "\(baseUrl)\(endpoint)?api_key=\(apiKey)&language=\(language)&page=1"

        guard let url = URL(string: fullURLString) else {
            throw AppError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await session.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func getCredits<T: Decodable>(type: T.Type, endpoint: String) async throws -> T {
        let apiKey = keychain.get("apiKey") ?? ""
        let fullURLString = "\(baseUrl)\(endpoint)?api_key=\(apiKey)"

        guard let url = URL(string: fullURLString) else {
            throw AppError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await session.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }

}

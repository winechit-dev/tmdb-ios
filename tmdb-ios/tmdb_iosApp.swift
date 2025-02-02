//
//  tmdb_iosApp.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 26/1/2568 BE.
//

import SwiftUI
import SwiftData

@main
struct tmdb_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FavoriteMovie.self)
    }
}

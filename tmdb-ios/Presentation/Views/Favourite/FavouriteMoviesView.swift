//
//  FavouriteMoviesView.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 2/2/2568 BE.
//

import SwiftUI
import SwiftData
import Kingfisher

struct FavouriteMoviesView : View {
    
    @Query var favourites: [FavoriteMovie]
    
    var body: some View {
        FavouriteMoviesContent(list: favourites)
    }
}

struct FavouriteMoviesContent : View {
    let list : [FavoriteMovie]
    let columns = [
           GridItem(.flexible(), spacing: 10),
           GridItem(.flexible(), spacing: 10)
       ]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
               // Text("Favourites").font(.headlineMedium).padding(.horizontal)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(list, id: \.movieId) { movie in
                            NavigationLink(
                                destination: createDetailView(
                                    for: MovieDetails(
                                        id: movie.movieId,
                                        name: movie.originalTitle,
                                        posterPath: movie.posterPath
                                    )
                                )
                            ) {
                                KFImage(URL(string:movie.posterPath))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .background(.gray.opacity(0.4))
                                    .cornerRadius(8)
                                    .clipped()
                            }
                        }
                    }
                    .padding()
                }
            }.navigationBarTitle("Favourites")
        }
    }
}
#Preview {
    FavouriteMoviesContent(
        list: [
            FavoriteMovie(movieId: 1, posterPath: "", originalTitle: ""),
            FavoriteMovie(movieId: 2, posterPath: "", originalTitle: ""),
            FavoriteMovie(movieId: 3, posterPath: "", originalTitle: "")
        ]
    )
}


#Preview {
    FavouriteMoviesView().modelContainer(PreviewHelper.modelContainer)
}

struct PreviewHelper {
    static let config = ModelConfiguration(isStoredInMemoryOnly: true)
    static let modelContainer =  try! ModelContainer(for: FavoriteMovie.self, configurations: config)
}

//
//  MovieList.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 6/2/2568 BE.
//

import SwiftUI
import Kingfisher

struct MovieListView : View {
    let title: String
    @ObservedObject var viewModel : MovieListViewModel
    var body: some View {
        MovieListContent(title: "", list: viewModel.uiState.movies)
            .alert(
                "Error",
                isPresented: Binding(
                     get: { !viewModel.uiState.errorMessage.isEmpty },
                     set: { _ in viewModel.uiState.errorMessage = "" }
                )) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewModel.uiState.errorMessage)
                }
    }
}

struct MovieListContent : View {
    let title: String
    let list : [MovieModel]
    let columns = [
           GridItem(.flexible(), spacing: 10),
           GridItem(.flexible(), spacing: 10)
       ]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(list, id: \.id) { movie in
                            NavigationLink(
                                destination: createDetailView(
                                    for: MovieDetails(
                                        id: movie.id,
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
            }.navigationBarTitle(title)
        }
    }
}

#Preview{
    MovieListView(
        title: "Movies",
        viewModel: MovieListViewModel.init(type: .nowPlaying)
    )
}

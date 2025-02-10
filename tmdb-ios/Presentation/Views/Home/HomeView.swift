//
//  Discover.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 28/1/2568 BE.
//

import SwiftUI
import Kingfisher
import Shimmer

struct HomeView : View{
    @StateObject var viewModel : HomeViewModel = .init()
    @State private var searchText: String = ""
    
    var body : some View{
        NavigationView {
            VStack(alignment: .leading){
                //headerSection
                ScrollView(.vertical, showsIndicators: false) {
                    if viewModel.uiState.isLoading {
                        ShimmerView()
                    } else {
                        VStack(alignment: .leading, spacing: 0){
                            
                            MoviesSection(
                                title: "Today Trending",
                                type: .trendingToday,
                                movies: viewModel.uiState.trendingTodayMovies
                            )
                            
                            MoviesSection(
                                title: "Popular",
                                type: .popular,
                                movies: viewModel.uiState.popularMovies
                                
                            )
                            
                            MoviesSection(
                                title: "Upcoming",
                                type: .upcoming,
                                movies: viewModel.uiState.upcomingMovies
                            )
                            
                            MoviesSection(
                                title: "Now Playing",
                                type: .nowPlaying,
                                movies: viewModel.uiState.nowPlayingMovies
                            )
                            
                            MoviesSection(
                                title: "Top Rated",
                                type: .topRated,
                                movies: viewModel.uiState.topRatedMovies
                            )
                            
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("Movies")
            .searchable(text: $searchText)
            .onChange(of: searchText) { oldValue, newValue in
                viewModel.searchMovies(searchText: newValue)
            }
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

    var headerSection : some View{
        VStack(alignment: .leading, spacing: 6){
         
            Text("Welcome")
                .font(.headlineMedium)
            Text("Millions of movies, TV shows and people to discover. Explore now.")
                .font(.titleSmall)
                
        }.padding(.horizontal)
    }
}


struct MoviesSection: View {
    let title: String
    let type : MovieType
    let movies: [MovieModel]
    
    var body: some View {
        if !movies.isEmpty {
            VStack(alignment: .leading) {
                
                HStack(alignment: .center){
                    Text(title)
                        .font(.titleMedium)
                        .bold()
                        .padding(.leading)
                        .padding(.bottom,6)
                    Spacer()
                    NavigationLink(
                        destination:MovieListView(title: title, viewModel: MovieListViewModel.init(type: type))
                    ){
                        Text("See More")
                            .font(.bodyMedium)
                            .padding(.trailing)
                    }
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(movies) { movie in
                            NavigationLink(
                                destination:createDetailView(
                                    for: MovieDetails(
                                        id: movie.id,
                                        name: movie.originalTitle,
                                        posterPath: movie.posterPath
                                    )
                                )
                            ) {
                                VStack {
                                    KFImage(URL(string:movie.posterPath))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(8)
                                        .clipped()
                                }
                                .padding(.vertical, 0)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }.padding(.horizontal,0)
            }
            .padding(.vertical, 16)
        }
    }
}

@ViewBuilder
func createDetailView(for movie: MovieDetails) -> some View {
    MovieDetailsView(
        args: movie,
        viewModel:MovieDetailsViewModel(movieId: movie.id)
    )
}

struct ShimmerView: View {
    @State private var isLoading = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(0..<5, id: \.self) { _ in
                VStack(alignment: .leading) {
                   
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 20)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<5, id: \.self) { _ in
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(10)
                                    
                                }
                                .padding(.trailing, 10)
                            }
                        } .padding(.horizontal)
                    }
                }
               
                .padding(.bottom, 20)
            }
        }
        .redacted(reason: .placeholder)
        .modifier(Shimmer())
    }
}

#Preview {
    HomeView()
}


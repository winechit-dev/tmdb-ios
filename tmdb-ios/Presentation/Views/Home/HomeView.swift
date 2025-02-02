//
//  Discover.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 28/1/2568 BE.
//

import SwiftUI
import Kingfisher

struct HomeView : View{
    @StateObject var viewModel : HomeViewModel = .init()
    
    var body : some View{
        NavigationView{
            VStack(alignment: .leading){
                headerSection
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0){
                        
                        MoviesSection(
                            title: "Today Trending",
                            movies: viewModel.trendingTodayMovies
                        )
                        
                        MoviesSection(
                            title: "Popular",
                            movies: viewModel.popularMovies
                        )
                        
                        MoviesSection(
                            title: "Upcoming",
                            movies: viewModel.upcomingMovies
                        )
                        
                        MoviesSection(
                            title: "Now Playing",
                            movies: viewModel.nowPlayingMovies
                        )
                        
                        MoviesSection(
                            title: "Top Rated",
                            movies: viewModel.topRatedMovies
                        )
                        
                        Spacer()
                    }
                }
            }.alert("Error", isPresented: .constant(!viewModel.errorMessage.isEmpty), actions: {
                Button {
                    
                } label: {
                    Text("Ok")
                }
                
            }, message: {
                Text(viewModel.errorMessage)
            })
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
    let movies: [MovieModel]
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.titleMedium)
                    .bold()
                    .padding(.leading)
                    .padding(.bottom,6)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(movies) { movie in
                            NavigationLink(
                                destination:createDetailView(for: movie)
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
    
    @ViewBuilder
    private func createDetailView(for movie: MovieModel) -> some View {
        MovieDetailsView(
            args: MovieDetails(
                id: movie.id,
                name: movie.originalTitle,
                posterPath: movie.posterPath
            ),
            viewModel:MovieDetailsViewModel(movieId: movie.id)
        )
    }
}

#Preview {
    HomeView()
}


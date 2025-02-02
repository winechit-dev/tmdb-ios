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
    @StateObject var movieDetailsViewModel: MovieDetailsViewModel = .init()
        @State var _details: MovieDetails? = nil
    
    var body : some View{
        VStack(alignment: .leading){
            headerSection
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                
                    MoviesSection(
                        title: "Today Trending",
                        movies: viewModel.trendingTodayMovies
                    ) { details in
                        self._details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                    }
                    
                    MoviesSection(
                        title: "Popular",
                        movies: viewModel.popularMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                    }
                    
                    MoviesSection(
                        title: "Upcoming",
                        movies: viewModel.upcomingMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                    }
                    
                    MoviesSection(
                        title: "Now Playing",
                        movies: viewModel.nowPlayingMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                    }
                    
                    MoviesSection(
                        title: "Top Rated",
                        movies: viewModel.topRatedMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                    }
                    
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
        .sheet(item: $_details, content: { details in
            MovieDetailsView(
                args: details,
                onEvent: {event in
                   
                        switch event {
                        case .navigateUp:
                            _details = nil
                            
                        case .movieDetails(let movie):
                            _details = MovieDetails(
                                id: movie.id,
                                name: movie.name,
                                posterPath: movie.posterPath
                            )
                            movieDetailsViewModel.getDetails(movieId: movie.id)
                            
                            
                        default:
                            break
                        }
                    
                },
                viewModel:movieDetailsViewModel
            )
        })
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
    let onTap: (MovieDetails) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.titleMedium)
                .bold()
                .padding(.leading) // Add padding for title alignment
                .padding(.bottom,6)
            
        
            ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll view
                HStack(spacing: 10) { // Ensure space between images
                    ForEach(movies) { movie in
                        VStack {
                            KFImage(URL(string:movie.posterPath))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 150)
                                .cornerRadius(8)
                                .clipped()
                                .onTapGesture {
                                    onTap(
                                        MovieDetails(
                                            id: movie.id,
                                            name: movie.originalTitle,
                                            posterPath: movie.posterPath
                                        )
                                    )
                                }

                        }
                        .padding(.vertical, 0)
                    }
                }
                .padding(.horizontal)
            
            }.padding(.horizontal,0)
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    HomeView()
}


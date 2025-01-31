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
    
    @State private var isPresentingDetails = false
    @State var _details: MovieDetails? = nil
    
    var body : some View{
        VStack{
            HeaderSection().padding()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                
                    MoviesSection(
                        title: "Today Trending",
                        movies: viewModel.trendingTodayMovies
                    ) { details in
                        self._details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                        self.isPresentingDetails = true
                    }
                    
                    MoviesSection(
                        title: "Popular",
                        movies: viewModel.popularMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                        self.isPresentingDetails = true
                    }
                    
                    MoviesSection(
                        title: "Upcoming",
                        movies: viewModel.upcomingMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                        self.isPresentingDetails = true
                    }
                    
                    MoviesSection(
                        title: "Now Playing",
                        movies: viewModel.nowPlayingMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                        self.isPresentingDetails = true
                    }
                    
                    MoviesSection(
                        title: "Top Rated",
                        movies: viewModel.topRatedMovies
                    ){ details in
                        _details = details
                        movieDetailsViewModel.getDetails(movieId: details.id)
                        self.isPresentingDetails = true
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
                onEvent: {movieDetailsEvent in
                },
                viewModel:movieDetailsViewModel
            )
        })
       

    }
}

struct HeaderSection : View{
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            Text("Welcome")
                .font(.custom("Metropolis-SemiBold", size:28))
    
            Text("Millions of movies, TV shows and people to discover. Explore now.")
                .font(.custom("Metropolis-Regular", size:14))
                .padding(.top,6)
        }
        
    }
}

struct MoviesSection: View {
    let title: String
    let movies: [MovieModel]
    let onTap: (MovieDetails) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Metropolis-SemiBold", size: 16))
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


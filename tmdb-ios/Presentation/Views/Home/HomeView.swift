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
        VStack{
            HeaderSection().padding()
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



let moviesPreview: [Movie] = [
    Movie(id: 1, title: "", overview: "", posterPath: ""),
    Movie(id: 2, title: "", overview: "", posterPath: ""),
    Movie(id: 3, title: "", overview: "", posterPath: ""),
    Movie(id: 4, title: "", overview: "", posterPath: "")
]



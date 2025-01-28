//
//  Discover.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 28/1/2568 BE.
//

import SwiftUI
import Kingfisher

struct HomeView : View{
    var body : some View{
        VStack{
            HeaderSection().padding()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                
                    MoviesSection(title: "Today Trending",movies: moviesPreview)
                    MoviesSection(title: "Popular",movies: moviesPreview)
                    MoviesSection(title: "Upcoming",movies: moviesPreview)
                    MoviesSection(title: "Now Playing",movies: moviesPreview)
                    MoviesSection(title: "Top Rated",movies: moviesPreview)
                    Spacer()
                }
            }
        }.frame(width: .infinity,height: .infinity)
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
    let movies: [Movie]
    
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
                            if let posterPath = movie.posterPath, !posterPath.isEmpty {
                               let url = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")
                                KFImage(url)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                                    .clipped()
                            } else {
                                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                    .fill(Color.gray.opacity(0.4))
                                    .frame(width: 100, height: 150)
                                
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



let moviesPreview: [Movie] = [
    Movie(id: 1, title: "", overview: "", posterPath: ""),
    Movie(id: 2, title: "", overview: "", posterPath: ""),
    Movie(id: 3, title: "", overview: "", posterPath: ""),
    Movie(id: 4, title: "", overview: "", posterPath: "")
]



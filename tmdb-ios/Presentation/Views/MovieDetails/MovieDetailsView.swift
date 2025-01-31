//
//  MovieDetails.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


import SwiftUI

struct MovieDetails: Identifiable {
    let id: Int
    let name: String
    let posterPath: String
}

struct MovieDetailsView: View {
    let args: MovieDetails
    let onEvent: (MovieDetailsEvent) -> Void
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    
    var body: some View {
        MovieDetailsContent(
            args: args,
            uiState: viewModel.uiState,
            onEvent: { event in
                switch event {
                //case .onToggleFavorite: viewModel.onToggleFavorite()
                default:
                    onEvent(event)
                }
            }
        )
    }
}

struct MovieDetailsContent: View {
    let args: MovieDetails
    let uiState: MovieDetailsUIState
    let onEvent: (MovieDetailsEvent) -> Void
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                posterSection
                VStack(spacing: 0) {
                    headSection
                    overviewSection
                    castSection
                    categoriesSection
                    recommendationsSection
                }
                .frame(maxWidth: .infinity)
                .padding(.top,350)
               
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: backButton,
            trailing: favoriteButton
        )
    }
    
    private var backButton: some View {
        Button(action: { onEvent(.navigateUp) }) {
            Image(systemName: "chevron.left")
        }
    }
    
    private var favoriteButton: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            onEvent(.onToggleFavorite)
        }) {
            Image(systemName: uiState.favorite ? "heart.fill" : "heart")
        }
        .disabled(uiState.details == nil)
    }
    
    private var posterSection : some View{
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: args.posterPath)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
            } placeholder: {
                Color.gray
            }
            .padding(0)
            .overlay {
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .white.opacity(0.1),.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }
    
    private var headSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack() {
                VoteAverageView(progress: uiState.details?.voteAverage)
                
                VStack(alignment: .leading,spacing: 6) {
                    Text(args.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let releaseDate = uiState.details?.releaseDate {
                        Text(releaseDate)
                            .font(.body)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 12)
                    }
                }
                Spacer()
            }.padding(.horizontal,20)
        }.frame(maxWidth: .infinity)
    }
    
    private var overviewSection: some View {
        Group {
            if let overview = uiState.details?.overview, !overview.isEmpty {
                Text(overview)
                    .padding()
                
                if uiState.details?.video == true {
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Video Trailer")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    private var castSection: some View {
        Group {
            if let cast = uiState.details?.cast, !cast.isEmpty {
                VStack(alignment: .leading) {
                    Text("Cast")
                        .font(.headline)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(cast, id: \.id) { actor in
                                VStack {
                                    AsyncImage(url: URL(string: actor.profilePath)) { image in
                                        image.resizable()
                                             .aspectRatio(contentMode: .fill)
                                             .frame(width: 65, height: 65)
                                             .clipShape(Circle())
                                    } placeholder: {
                                        Color.gray
                                    }
                                    
                                    Text(actor.originalName)
                                        .font(.caption)
                                        .frame(width: 65)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var categoriesSection: some View {
        Group {
            if let genres = uiState.details?.genres, !genres.isEmpty {
                VStack(alignment: .leading) {
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(genres, id: \.id) { genre in
                                Text(genre.name)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(16)
                            }
                        }.padding(.horizontal)
                    }.padding(.horizontal,0)
                }
            }
        }
    }
    
    private var recommendationsSection: some View {
        Group {
            if let recommendations = uiState.details?.recommendations, !recommendations.isEmpty {
                VStack(alignment: .leading) {
                    Text("Recommendations")
                        .font(.headline)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(recommendations, id: \.id) { movie in
                                // MovieItem view would be implemented separately
                                Text(movie.title)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct VoteAverageView: View {
    let progress: Float?
    
    var body: some View {
        Group {
            if let progress = progress, progress > 0 {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 5)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(progress / 10))
                        .stroke(Color.blue, lineWidth: 5)
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(Int(progress * 10))%")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .frame(width: 60, height: 60)
            }
        }
    }
}

enum MovieDetailsEvent {
    case navigateUp
    case onToggleFavorite
    case movieDetails(model: MovieModel, type: String)
}


#Preview{
    MovieDetailsView(
        
        args: MovieDetails(
            id: 1, 
            name: "Name",
            posterPath: ""
        ),
        onEvent: { MovieDetailsEvent in
            
        },
        viewModel: MovieDetailsViewModel()
    )
}

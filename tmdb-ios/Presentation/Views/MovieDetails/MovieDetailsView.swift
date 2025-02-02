//
//  MovieDetails.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 31/1/2568 BE.
//


import SwiftUI
import SwiftData

struct MovieDetails: Identifiable {
    let id: Int
    let name: String
    let posterPath: String
}

struct MovieDetailsView: View {
    let args: MovieDetails
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        MovieDetailsContent(
            args: args,
            uiState: viewModel.uiState
        )
    }
}

struct MovieDetailsContent: View {
    let args: MovieDetails
    let uiState: MovieDetailsUIState
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                posterSection
                toolbarSection
                VStack(spacing: 0) {
                    headSection
                    overviewSection
                    categoriesSection
                    castSection
                    recommendationsSection
                }
                .frame(maxWidth: .infinity)
                .padding(.top,350)
                
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
    
    private var toolbarSection : some View{
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(.white.opacity(0.5))
                    )
            }
            
            Spacer()
            
            Button(action: {
                modelContext.insert(
                    FavoriteMovie(
                        movieId: args.id,
                        posterPath: args.posterPath,
                        originalTitle: args.name
                    )
                )
            }) {
                Image(systemName: "heart")
                    .foregroundColor(.black)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(.white.opacity(0.5))
                    )
            }
        }
        .padding(.horizontal)
        .padding(.top, 60)
    }
    private var posterSection : some View{
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: args.posterPath)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
            } placeholder: {
                Color.gray.opacity(0.5)
            }
            .overlay {
                LinearGradient(
                    gradient: Gradient(
                    colors: [.clear,.clear,.white.opacity(0.1),.white,.white]),
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
                
                VStack(alignment: .leading,spacing: 2) {
                    Text(args.name)
                        .font(.titleLarge)
                        .fontWeight(.bold)
                    
                    if let releaseDate = uiState.details?.releaseDate {
                        Text(releaseDate)
                            .font(.bodyLarge)
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
                    .font(.bodyMedium)
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
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
    }
    
    private var castSection: some View {
        Group {
            if let cast = uiState.details?.cast, !cast.isEmpty {
                VStack(alignment: .leading,spacing: 4) {
                    Text("Cast")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(cast, id: \.id) { actor in
                                VStack(spacing: 2) {
                                    AsyncImage(url: URL(string: actor.profilePath)) { image in
                                        image.resizable()
                                             .aspectRatio(contentMode: .fill)
                                             .frame(width: 65, height: 65)
                                             .clipShape(Circle())
                                    } placeholder: {
                                        Circle()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(width: 65, height: 65)
                                                    
                                    }
                                    
                                    Text(actor.originalName)
                                        .frame(width: 65)
                                        .lineLimit(3)
                                        .font(.labelMedium)
                                    
                                }.padding(0)
                            }
                        }.padding(.horizontal)
                    }
                }.padding(.top)
            }
        }
    }
    
    private var categoriesSection: some View {
        Group {
            if let genres = uiState.details?.genres, !genres.isEmpty {
                VStack(alignment: .leading,spacing: 6) {
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(genres, id: \.id) { genre in
                                Text(genre.name)
                                    .font(.labelSmall)
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
                
                MoviesSection(
                    title: "Recommendations",
                    movies: recommendations
                )
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
                        .font(.bodyMedium)
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
    case movieDetails(model: MovieDetails)
}


#Preview{
    MovieDetailsContent(
        args: MovieDetails(
            id: 1, 
            name: "The Lord of the Rings : The War",
            posterPath: ""
        ),
        uiState: MovieDetailsUIState(
            details: movieDetailsPreview
        )
    )
}

let movieDetailsPreview = MovieDetailsModel(
    adult: false,
    backdropPath: "/jlWk4J1sV1EHgkjhvsN7EdzGvOx.jpg",
    budget: 17500000,
    genres: [
        GenreModel(
            id: 1,
            name: "Action"
        ),
        GenreModel(
            id: 2,
            name: "Adventure"
        ),
        GenreModel(
            id: 3,
            name: "Animation"
        ),
        GenreModel(
            id: 4,
            name: "Comedy"
        )
    ],
    homepage: "https://www.the-match-factory.com/catalogue/films/the-substance.html",
    id: 933260,
    imdbId: "",
    originalLanguage: "",
    originalTitle: "The Substance",
    overview: "A fading celebrity decides to use a black market drug, a cell-replicating substance that temporarily creates a younger, better version of herself.",
    popularity: 4536.856,
    posterPath: "/lqoMzCcZYEFK729d6qzt349fB4o.jpg",
    releaseDate: "2024-09-07",
    revenue: 29106531,
    runtime: 141,
    status: "",
    tagline: "If you follow the instructions, what could go wrong?",
    title: "The Substance",
    video: true,
    voteAverage: 5.4,
    voteCount: 568,
    cast: [
        CastModel(
            castId: 1,
            id: 1,
            originalName: "User A",
            profilePath: ""
        ),
        CastModel(
            castId: 2,
            id: 2,
            originalName: "User B",
            profilePath: ""
        ),
        CastModel(
            castId: 3,
            id: 3,
            originalName: "User C",
            profilePath: ""
        ),
        CastModel(
            castId: 4,
            id: 4,
            originalName: "User D",
            profilePath: ""
        )
    ]
)

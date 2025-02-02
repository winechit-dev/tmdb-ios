//
//  ContentView.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 26/1/2568 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    var body: some View {
    
        VStack(spacing: 0){
        
            TabView {
                
                HomeView().tabItem {
                   // TabItem1(image: "discover",label: "Discover")
                    Image(systemName: "house")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24,height: 24)
                    Text("Home")
                        .font(.custom("Metropolis-Regular", size:12))
                
                }
                FavouriteMoviesView().tabItem {
                    Image(systemName: "heart")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24,height: 24)
                    Text("Favourite")
                        .font(.custom("Metropolis-Regular", size:12))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

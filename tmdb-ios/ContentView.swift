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
    
        VStack{
        
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Discover").font(.largeTitle)
                }
                .tag(0)

                VStack {
                    Text("Favorites").font(.largeTitle)
                }.tag(1)

        
            }
            
            HStack {
                TabItem(
                    selectedTab : $selectedTab,
                    image : "discover",
                    label : "Discover",
                    tag : 0,
                    action: {selectedTab = 0}
                )
            
                TabItem(
                    selectedTab : $selectedTab,
                    image : "favourite",
                    label : "Favourite",
                    tag : 1,
                    action : {selectedTab = 1}
                )
            
            
            }
            .padding()
            .background(
                Color.white // any non-transparent background
                    .shadow(color: .lightGrey.opacity(0.2), radius: 10, x: 0, y: 0)
                    .mask(Rectangle().padding(.top, -20))
            )
        
           
        }
    }
}

struct TabItem : View{
    @Binding var selectedTab: Int
    
    let image : String
    let label: String
    let tag: Int
    let action: @MainActor () -> Void
    
    var body: some View{
        let color: Color = selectedTab == tag ? .blue : .lightGrey
        let fontName : String = selectedTab == tag ? "Metropolis-SemiBold" : "Metropolis-Regular"
        Button(action: action) {
            VStack(spacing: 2){
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(color)
                    .frame(width: 24,height: 24)
                Text(label)
                    .foregroundStyle(color)
                    .font(.custom(fontName, size:12))
            }
        }.frame(maxWidth: .infinity)
    }
}


#Preview {
    ContentView()
}

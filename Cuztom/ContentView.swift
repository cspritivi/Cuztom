//
//  ContentView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 6/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            ProfileView()
            .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}

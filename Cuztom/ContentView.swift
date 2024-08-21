//
//  ContentView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 6/22/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        
        NavigationView {
            if authViewModel.isAuthenticated {
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
            } else {
                LoginView1()
                    .environmentObject(authViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}

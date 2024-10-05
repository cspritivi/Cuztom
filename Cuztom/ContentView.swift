//
//  ContentView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 6/22/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    OrderView()
                        .tabItem {
                            Image(systemName: "plus.app.fill")
                            Text("Order")
                        }
                    FavoritesView()
                        .tabItem {
                            Image(systemName: "suit.heart.fill")
                            Text("Saved")
                        }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Profile")
                        }
                }
            } else {
                LoginView1()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}

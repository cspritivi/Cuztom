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
                ProfileView()
            } else {
                LoginView1()
            }
        }
    }
    
//    var body: some View {
//        
//        NavigationView {
//            
//            if authViewModel.isAuthenticated {
//                NavigationStack {
//                    TabView {
//                        HomeView()
//                            .tabItem {
//                                Label("Home", systemImage: "house.fill")
//                            }
//                        
//                        ProfileView()
//                            .tabItem {
//                                Label("Profile", systemImage: "person.crop.circle.fill")
//                            }
//                        
//                        
//                    }
//                }
//                
//            } else {
//                LoginView1()
//            }
//        }
//    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}

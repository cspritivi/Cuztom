//
//  CuztomApp.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 6/22/24.
//

import SwiftUI
import Firebase

@main
struct CuztomApp: App {
    
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}

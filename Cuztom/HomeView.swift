//
//  HomeView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                    .font(.largeTitle)
                Text("Started the project today")
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.automatic)
            .padding()
        }
    }
}

#Preview {
    HomeView()
}

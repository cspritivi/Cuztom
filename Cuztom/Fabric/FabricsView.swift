//
//  FabricsView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

import SwiftUI

struct FabricsView: View {
    
    @State var fabrics: [Fabric]? = nil
    let filter: String
    @State var isLoading: Bool = true
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let fabricViewModel = FabricViewModel()
    
    init(filter: String) {
        self.filter = filter
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(self.fabrics ?? [], id: \.self) { fabric in
                                    NavigationLink(destination: FabricDetailView(fabric: fabric)) {
                                        FabricThumbnailView(fabric: fabric, fabricViewModel: fabricViewModel)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .task {
            do {
                try await fetchFabrics(filter: self.filter)
                isLoading = false
            } catch {
                print(error.localizedDescription)
            }
        }
        .navigationTitle("Fabrics")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchFabrics(filter: String) async throws {
        fabricViewModel.fetchFabrics()
        self.fabrics = fabricViewModel.fabrics
    }
}

#Preview {
    NavigationStack {
        FabricsView(filter: "all")
    }
}

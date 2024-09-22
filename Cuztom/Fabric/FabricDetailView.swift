//
//  FabricDetailView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

import SwiftUI

struct FabricDetailView: View {
    let fabric: Fabric
    var body: some View {
        ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(fabric.images, id: \.self) { imageName in
                                    Image(uiImage: imageName) // Use AsyncImage for remote URLs
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 200)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(fabric.uid)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(fabric.type)
                                .font(.body)
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationTitle(fabric.uid)
                .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FabricDetailView(fabric: Fabric(type:"Type 1", images: []))
}

//
//  FabricThumbnailView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

import SwiftUI

struct FabricThumbnailView: View {
    let fabric: Fabric
    var body: some View {
        VStack {
//            Image(uiImage: fabric.images[0]) // Assuming local images, use AsyncImage for remote URLs
//                .resizable()
//                .scaledToFill()
//                .frame(width: 80, height: 80)
//                .clipped()
//                .cornerRadius(10)
            Text(fabric.id)
                .font(.caption)
                .lineLimit(1)
        }
    }
}

#Preview {
    FabricThumbnailView(fabric: Fabric(id: UUID().uuidString, fabricType: "Cotton", description: "020", imageURLs: []))
}

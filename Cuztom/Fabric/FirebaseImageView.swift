//
//  FirebaseImageView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/30/24.
//

import SwiftUI
import FirebaseStorage

struct FirebaseImageView: View {
    @State private var imageURL: URL?
    let imagePath: String
    
    init(imagePath: String) {
        self.imagePath = imagePath
    }
    
    var body: some View {
        Group {
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        let storage = Storage.storage()
        let reference = storage.reference().child(imagePath)
        
        reference.downloadURL { url, error in
            if let error = error {
                print("Error getting download URL: \(error.localizedDescription)")
            } else if let url = url {
                self.imageURL = url
            }
        }
    }
}

#Preview {
    FirebaseImageView(imagePath: "fabric_images/Cotton/10/im_1.png")
}

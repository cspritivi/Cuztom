//
//  FabricViewModal.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FabricViewModel: ObservableObject {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    @Published var fabrics: [Fabric] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var images: [String: [UIImage]] = [:]
    
    @MainActor
        func fetchFabrics() async throws -> [Fabric] {
            isLoading = true
            errorMessage = nil
            
            do {
                let snapshot = try await db.collection("fabrics").getDocuments()
                let fetchedFabrics = snapshot.documents.compactMap { document -> Fabric? in
                    let data = document.data()
                    guard let fabricType: String = data["type"] as? String,
                          let imageURLs: [String] = data["imageURLs"] as? [String] else {
                        print("Error getting fabrics")
                        return nil
                    }
                    return Fabric(id: document.documentID, fabricType: fabricType, imageURLs: imageURLs)
                }
                
                self.fabrics = fetchedFabrics
                isLoading = false
                return fetchedFabrics
            } catch {
                isLoading = false
                self.errorMessage = "Failed to fetch fabrics: \(error.localizedDescription)"
                throw error
            }
        }
    
    func loadImageURLs(for fabric: Fabric) async -> [URL] {
        var imageURLs: [URL] = []
        
        for imageURL in fabric.imageURLs {
            let reference = storage.reference().child(imageURL)
            do {
                let url = try await reference.downloadURL()
                imageURLs.append(url)
            } catch {
                print("Error getting download URL: \(error.localizedDescription)")
            }
        }
        return imageURLs
    }
    
    func loadImages(for fabric: Fabric) async -> [UIImage] {
        if let cachedImages = self.images[fabric.id] {
            return cachedImages
        }
        
        let imageURLs = await loadImageURLs(for: fabric)
        for imageURL in imageURLs {
            
            if let (data, _) = try? await URLSession.shared.data(from: imageURL), let uiImage = UIImage(data: data) {
                await MainActor.run {
                    if self.images[fabric.id] != nil {
                        self.images[fabric.id]!.append(uiImage)
                    } else {
                        self.images[fabric.id] = [uiImage]
                    }
                }
            }
        }
        
        return self.images[fabric.id] ?? []
    }
}

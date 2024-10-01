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
        
        
//        do {
//            let snapshot = try await db.collection("fabrics").getDocuments()
//            self.fabrics = snapshot.documents.compactMap({ document -> Fabric? in
//                let data = document.data()
//                print(data)
//                guard let fabricType: String = data["type"] as? String,
//                      let imageURLs: [String] = data["imageURLs"] as? [String] else {
//                    print("Error getting fabrics")
//                    return nil
//                }
//                return Fabric(id: document.documentID, fabricType: fabricType, imageURLs: imageURLs)
//            })
//        } catch {
//            print("Faield to fetch fabrics: \(error.localizedDescription)")
//        }
        
//        isLoading = false
    
    func loadImageURLs(for fabric: Fabric) async -> [URL] {
        print("Entering loadImageURLs")
        var imageURLs: [URL] = []
        let storage = Storage.storage()
        
        for imageURL in fabric.imageURLs {
            print(imageURL)
            let reference = storage.reference().child(imageURL)
            do {
                let url = try await reference.downloadURL()
                imageURLs.append(url)
            } catch {
                print("Error getting download URL: \(error.localizedDescription)")
            }
        }
        
        print(imageURLs)
        return imageURLs
    }
}

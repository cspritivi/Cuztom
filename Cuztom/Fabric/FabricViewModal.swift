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

class FabricViewModel {
    @Published var fabrics: [Fabric] = []
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func fetchFabrics() {
        db.collection("fabrics").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error while fetching the fabrics from Firebase: \(error)")
            } else {
                self.fabrics = querySnapshot!.documents.compactMap { document in
                    let data = document.data()
                    guard   let id = data["id"] as? String,
                            let description = data["description"] as? String,
                            let imageURLs = data["imageURLs"] as? [String],
                            let type = data["type"] as? String else {
                                return nil
                    }
                    return Fabric(id: id, fabricType: type, description: description, imageURLs: imageURLs)
                }
            }
            
        }
    }
    
    func loadImage(url: String) async -> UIImage? {
        do {
            let storageReference = storage.reference(forURL: url)
            let data = try await storageReference.data(maxSize: 5 * 1024 * 1024) // 5MB max size
            return UIImage(data: data)
        } catch {
            print("Error downloading image: \(error)")
            return nil
        }
    }
    
    
    func uploadFabric(_ fabric: Fabric) async {
            var uploadedImageURLs: [String] = []
            
            for imageData in await getImageDataArray(for: fabric) {
                let imageName = UUID().uuidString
                let imageRef = storage.reference().child("fabrics/\(imageName).jpg")
                
                do {
                    _ = try await imageRef.putDataAsync(imageData)
                    let downloadURL = try await imageRef.downloadURL().absoluteString
                    uploadedImageURLs.append(downloadURL)
                } catch {
                    print("Error uploading image: \(error)")
                }
            }
            
            let fabricData: [String: Any] = [
                "id" : fabric.id,
                "description" : fabric.description,
                "fabricType": fabric.fabricType,
                "imageURLs": uploadedImageURLs
            ]
            
            do {
                try await db.collection("fabrics").document(fabric.id).setData(fabricData)
                print("Fabric successfully written!")
            } catch {
                print("Error writing fabric to Firestore: \(error)")
            }
        }
        
        // This method would need to be implemented to get the image data for a fabric
        private func getImageDataArray(for fabric: Fabric) async -> [Data] {
            // Implementation depends on how you're storing/accessing the original images
            // This could involve loading from local storage, a cache, or another remote source
            fatalError("getImageDataArray(for:) not implemented")
        }
    }
//}

//class FabricViewModal {
//    
//    static func fetchAllFabrics() async throws -> [Fabric]? {
//        var fabrics: [Fabric] = []
//        
//        guard let fabricsFolder = Bundle.main.url(forResource: "Linen", withExtension: nil) else {
//            print("No Fabrics Found")
//            return nil
//        }
//        
//        do {
//            let fabricFolderURLs = try FileManager.default.contentsOfDirectory(at: fabricsFolder, includingPropertiesForKeys: nil)
//            
//            for fabricFolderURL in fabricFolderURLs {
//                let id = fabricFolderURL.lastPathComponent
//                
//                let imageURLs = try FileManager.default.contentsOfDirectory(at: fabricFolderURL, includingPropertiesForKeys: nil)
//                    .filter { $0.lastPathComponent.hasPrefix("im") }
//                
//                let images = imageURLs.compactMap { UIImage(contentsOfFile: $0.path()) }
//                
//                let metaDataURL = fabricFolderURL.appendingPathComponent("tag.txt")
//                guard let metaDataContent = try? String(contentsOf: metaDataURL) else {
//                    print("Failed to load metadata for \(id)")
//                    continue
//                }
//                
//                let type = extractType(from: metaDataContent)
////                let fabric = Fabric(uid: id, type: type, images: images)
//                let fabric = Fabric(id: UUID().uuidString, fabricType: "Cotton", description: "020", imageURLs: [])
//                
//                fabrics.append(fabric)
//                
//            }
//        } catch {
//            print("Error loading fabric: \(error.localizedDescription)")
//        }
//        return fabrics
//    }
//    
//    private static func extractType(from metadata: String) -> String {
//        let lines = metadata.components(separatedBy: .newlines)
//        guard lines.count >= 2 else { return "Unknown" }
//        let typesLine = lines[1]
//        let firstType = typesLine.components(separatedBy: " ").first ?? "Unknown"
//        return firstType
//    }
//}

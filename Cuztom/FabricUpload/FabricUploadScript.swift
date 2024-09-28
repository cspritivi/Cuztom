//
//  FabricUploadScript.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/25/24.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
class FabricUploader {
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    func processAndUploadFabrics(fromDirectory path: String,
                                 progressHandler: @escaping (Double) -> Void,
                                 completion: @escaping (Error?) -> Void) {
        let fileManager = FileManager.default
        guard let fabricTypes = try? fileManager.contentsOfDirectory(atPath: path) else {
            completion(NSError(domain: "FabricUploader", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error reading Fabrics directory"]))
            return
        }
        
        let totalFabrics = fabricTypes.reduce(0) { count, fabricType in
            let typePath = (path as NSString).appendingPathComponent(fabricType)
            let fabricFolders = (try? fileManager.contentsOfDirectory(atPath: typePath)) ?? []
            return count + fabricFolders.count
        }
        
        var processedFabrics = 0
        var lastReportedProgress = 0.0
        
        for fabricType in fabricTypes {
            let typePath = (path as NSString).appendingPathComponent(fabricType)
            guard let fabricFolders = try? fileManager.contentsOfDirectory(atPath: typePath) else {
                print("Error reading fabric type directory: \(fabricType)")
                continue
            }
            
            for fabricFolder in fabricFolders {
                let fabricPath = (typePath as NSString).appendingPathComponent(fabricFolder)
                guard let fabricImages = try? fileManager.contentsOfDirectory(atPath: fabricPath) else {
                    print("Error reading fabric folder: \(fabricFolder)")
                    continue
                }
                
                uploadFabricImages(type: fabricType, name: fabricFolder, images: fabricImages, basePath: fabricPath) { error in
                    if let error = error {
                        print("Error uploading fabric \(fabricFolder): \(error.localizedDescription)")
                    }
                    
                    processedFabrics += 1
                    let progress = Double(processedFabrics) / Double(totalFabrics)
                    if progress - lastReportedProgress >= 0.01 {
                        lastReportedProgress = progress
                        DispatchQueue.main.async {
                            progressHandler(progress)
                        }
                    }
                    
                    if processedFabrics == totalFabrics {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
    
    func uploadFabricImages(type: String, name: String, images: [String], basePath: String, completion: @escaping (Error?) -> Void) {
        var imageURLs: [String] = []
        let dispatchGroup = DispatchGroup()
        
        for image in images {
            dispatchGroup.enter()
            let imagePath = (basePath as NSString).appendingPathComponent(image)
            let imageRef = storage.reference().child("fabric_images/\(type)/\(name)/\(image)")
            
            imageRef.putFile(from: URL(fileURLWithPath: imagePath), metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image \(image): \(error.localizedDescription)")
                } else {
                    imageRef.downloadURL { url, error in
                        if let downloadURL = url?.absoluteString {
                            imageURLs.append(downloadURL)
                        }
                        dispatchGroup.leave()
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.saveFabricToFirestore(type: type, name: name, imageURLs: imageURLs, completion: completion)
        }
    }
    
    func saveFabricToFirestore(type: String, name: String, imageURLs: [String], completion: @escaping (Error?) -> Void) {
        let fabric = Fabric(id: UUID().uuidString, fabricType: type, description: name, imageURLs: imageURLs)
        db.collection("fabrics").document(fabric.id).setData(fabric.dictionary) { error in
            if let error = error {
                print("Error saving fabric \(name): \(error.localizedDescription)")
                completion(error)
            } else {
                print("Fabric saved successfully: \(name)")
                completion(nil)
            }
        }
    }
}

extension Encodable {
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String:Any] ?? [:]
    }
}



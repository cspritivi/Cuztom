import Firebase
import FirebaseStorage
import FirebaseFirestore

class FabricDirectoryScanner {
    private let storage = Storage.storage()
    private let db = Firestore.firestore()
    
    func scanAndUpload(completion: @escaping (Result<Void, Error>) -> Void) {
        let storageRef = storage.reference().child("fabric_images")
        scanDirectory(reference: storageRef) { result in
            switch result {
            case .success(let fabrics):
                self.uploadToFirestore(fabrics: fabrics, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func scanDirectory(reference: StorageReference, completion: @escaping (Result<[Fabric], Error>) -> Void) {
        var fabrics: [Fabric] = []
        
        reference.listAll { result in
            switch result {
            case .success(let listResult):
                let group = DispatchGroup()
                
                for prefixRef in listResult.prefixes {
                    // This is a fabric type directory
                    let fabricType = prefixRef.name
                    
                    group.enter()
                    self.scanFabricTypeDirectory(reference: prefixRef, fabricType: fabricType) { result in
                        switch result {
                        case .success(let fabricsForType):
                            fabrics.append(contentsOf: fabricsForType)
                        case .failure(let error):
                            print("Error scanning fabric type \(fabricType): \(error)")
                        }
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(.success(fabrics))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func scanFabricTypeDirectory(reference: StorageReference, fabricType: String, completion: @escaping (Result<[Fabric], Error>) -> Void) {
        var fabricsForType: [Fabric] = []
        
        reference.listAll { result in
            switch result {
            case .success(let listResult):
                let group = DispatchGroup()
                
                for fabricIdRef in listResult.prefixes {
                    // This is a fabric ID directory
                    let fabricId = fabricIdRef.name
                    
                    group.enter()
                    self.getImageURLs(reference: fabricIdRef) { result in
                        switch result {
                        case .success(let imageURLs):
                            let fabric = Fabric(id: fabricId, fabricType: fabricType, description: "", imageURLs: imageURLs)
                            fabricsForType.append(fabric)
                        case .failure(let error):
                            print("Error getting image URLs for fabric \(fabricId): \(error)")
                        }
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(.success(fabricsForType))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getImageURLs(reference: StorageReference, completion: @escaping (Result<[String], Error>) -> Void) {
        reference.listAll { result in
            switch result {
            case .success(let listResult):
                let imageURLs = listResult.items.map { $0.fullPath }
                completion(.success(imageURLs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func uploadToFirestore(fabrics: [Fabric], completion: @escaping (Result<Void, Error>) -> Void) {
        let group = DispatchGroup()
        var uploadError: Error?
        
        for fabric in fabrics {
            group.enter()
            db.collection("fabrics").document(fabric.id).setData([
                "type": fabric.fabricType,
                "imageURLs": fabric.imageURLs
            ]) { error in
                if let error = error {
                    uploadError = error
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if let error = uploadError {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

// Usage
//struct ContentView: View {
//    @State private var isScanning = false
//    @State private var scanResult: String?
//    
//    var body: some View {
//        VStack {
//            Button("Scan and Upload Fabrics") {
//                isScanning = true
//                scanResult = nil
//                let scanner = FabricDirectoryScanner()
//                scanner.scanAndUpload { result in
//                    isScanning = false
//                    switch result {
//                    case .success:
//                        scanResult = "Scan and upload completed successfully!"
//                    case .failure(let error):
//                        scanResult = "Error: \(error.localizedDescription)"
//                    }
//                }
//            }
//            .disabled(isScanning)
//            
//            if isScanning {
//                ProgressView()
//            }
//            
//            if let result = scanResult {
//                Text(result)
//            }
//        }
//    }
//}

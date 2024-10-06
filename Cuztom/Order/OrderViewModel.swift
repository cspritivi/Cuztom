//
//  OrderViewModel.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 10/6/24.
//

import Foundation
import FirebaseStorage
import Firebase

class OrderViewModel: ObservableObject {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    @Published var orderTypeImages: [String: UIImage]? = nil
    @Published var isLoading = false
    
    func loadOrderTypeImages() async {
        isLoading = true
        guard orderTypeImages == nil else { return }
        let storageRef = storage.reference().child("order_type_images")
        storageRef.listAll() { (result, error) in
            if let error = error {
                print("Error downloading files: \(error.localizedDescription)")
                return
            }
            
            guard let items = result?.items else {
                print("No items found in this folder.")
                return
            }
            
            let dispatchGroup = DispatchGroup()
            
            for item in items {
                print(item)
                dispatchGroup.enter()
                item.getData(maxSize: 5 * 1064 * 1064) { (data, error) in
                    
                    defer {
                        print(self.orderTypeImages)
                        dispatchGroup.leave()
                    }
                    
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                    } else if let data = data, let image = UIImage(data: data) {
                        if self.orderTypeImages == nil {
                            self.orderTypeImages = [item.name : image]
                        } else {
                            self.orderTypeImages![item.name] = image
                        }
                    }
                }
            }
            self.isLoading = false
        }
    }
}

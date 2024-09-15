//
//  FirebaseManager.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/14/24.
//

import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    
    func addMeasurement(_ measurement: CMeasurement) {
        do {
            try db.collection("measurements").document(measurement.id).setData(from: measurement)
        } catch let error {
            print("DEBUG: Error whilst adding a measurement to the DB: \(error.localizedDescription)")
        }
    }
    
    func getMeasurements(for customerID: String, completion: @escaping ([CMeasurement]) -> Void) {
        db.collection("measurements")
            .whereField("customerID", isEqualTo: customerID)
            .getDocuments { querySnapshot, error in
                if let error {
                    print("Error getting measurements: \(error.localizedDescription)")
                } else {
                    let measurements = querySnapshot?.documents.compactMap { try? $0.data(as: CMeasurement.self ) } ?? []
                    completion(measurements)
                }
            }
    }
    
    func fetchUser(userID: String, completion: @escaping (User?) -> Void) {
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { document, error in
            if let document, document.exists {
                do {
                    var user = try document.data(as: User.self)
                    
                    if let measurementsData = document.data()?["measurements"] as? [[String: Any]] {
                        user.measurements = try measurementsData.map(try Firestore.Decoder.decode(CMeasurement.self, from: $0))
                    }
                }
            }
        }
    }
}

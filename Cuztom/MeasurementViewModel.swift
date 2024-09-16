//
//  MeasurementViewModel.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/15/24.
//

import Foundation
import FirebaseFirestore

class MeasurementViewModel: ObservableObject {
    static let shared = MeasurementViewModel()
    private let db = Firestore.firestore()
    
    func addMeasurement(_ measurement: CMeasurement) async throws {
        do {
            try db.collection("measurements").document(measurement.id).setData(from: measurement)
        } catch let error {
            print("DEBUG: Error whilst adding a measurement to the DB: \(error.localizedDescription)")
        }
    }
    
    func fetchMeasurements(for customerID: String, completion: @escaping ([CMeasurement]) -> Void) async throws {
        do {
            let measurementsRef = db.collection("measurements").whereField("customerID", isEqualTo: customerID)
            let snapshot = try await measurementsRef.getDocuments()
            
            completion(snapshot.documents.compactMap { document in
                try? document.data(as: CMeasurement.self)
            })
        } catch {
            print("DEBUG: Error while fetching the user's measurements - \(error.localizedDescription)")
        }
    }
    
    func deleteMeasurement(id: String) async throws {
        try await db.collection("measurements").document(id).delete()
    }
    
    func updateMeasurement(_ measurement: CMeasurement) async throws {
        try db.collection("measurements").document(measurement.id).setData(from: measurement)
    }
    
    func getMeasurement(id: String) async throws -> CMeasurement {
        return try await db.collection("measurements").document(id).getDocument(as: CMeasurement.self)
    }
}

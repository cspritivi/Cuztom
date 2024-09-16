//
//  Measurement.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/28/24.
//

import Foundation

// https://www.ratioclothing.com/help/measure-a-shirt


class CMeasurement: Codable, Hashable {
    
    let id: String
    let createdAt: Date
    let measurementFor: String
    let values: [String]
    let customerID: String
    let type: String
    
    init(id: String = UUID().uuidString, measurementFor: String, values: [String], customerID: String, type: String) {
        self.id = id
        self.createdAt = Date()
        self.measurementFor = measurementFor
        self.values = values
        self.customerID = customerID
        self.type = type
    }
    
    static let typeToDetails: [String: [String]] = [
        "Shirt" : ["Chest", "Waist", "Seat", "Bicep", "Shirt Length", "Shoulder Length", "Sleeve Length", "Cuff Circuference", "Collar Size"],
        "Pant" : ["Waist", "Hip", "Abdomen", "Thigh", "Knee", "Calf", "Instep", "Side Length to Knee", "Side Length", "Crotch"]
    ]
}

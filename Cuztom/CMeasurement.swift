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
    
    init(id: String = UUID().uuidString, measurementFor: String, values: [String], customerID: String) {
        self.id = id
        self.createdAt = Date()
        self.measurementFor = measurementFor
        self.values = values
        self.customerID = customerID
    }
}

class ShirtMeasurement: CMeasurement {
    static let detailsNeeded:[String] = ["Chest", "Waist", "Seat", "Bicep", "Shirt Length", "Shoulder Length", "Sleeve Length", "Cuff Circuference", "Collar Size"]
}

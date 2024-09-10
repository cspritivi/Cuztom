//
//  Measurement.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/28/24.
//

import Foundation

// https://www.ratioclothing.com/help/measure-a-shirt


class CMeasurement: Codable, Hashable {
    
    var dateTaken: Date = .now
    var customer: User
    var forSelf: Bool
    var measurementFor: String
    var notes: String
    
    init(customer: User, forSelf: Bool, measurementFor: String, notes: String, detailsNeeded:[String]) {
        self.customer = customer
        self.forSelf = forSelf
        self.measurementFor = measurementFor
        self.notes = notes
    }
}

class ShirtMeasurement: CMeasurement {
    static let detailsNeeded:[String] = ["Chest", "Waist", "Seat", "Bicep", "Shirt Length", "Shoulder Length", "Sleeve Length", "Cuff Circuference", "Collar Size"]
}

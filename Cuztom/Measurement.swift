//
//  Measurement.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/28/24.
//

import Foundation

//https://www.ratioclothing.com/help/measure-a-shirt


class Measurement: Codable {
    var dateTaken: Date = .now
    var customer: User
    var forSelf: Bool
    var measurementFor: String
    var details: String
    var units: String
    var notes: String
}

class ShirtMeasurement: Measurement {
    static let detailsNeeded:[String] = ["Chest", "Waist", "Seat", "Bicep", "Shirt Length", "Shoulder Length", "Sleeve Length", "Cuff Circuference", "Collar Size"]
}

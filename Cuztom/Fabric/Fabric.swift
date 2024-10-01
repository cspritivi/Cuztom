//
//  Fabric.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

import Foundation
import UIKit

class Fabric: Hashable, Identifiable, Codable {
    let id: String
    let fabricType: String
    let description: String
    let imageURLs: [String]
    init(id: String, fabricType: String, description: String = "", imageURLs: [String]) {
        self.id = id
        self.fabricType = fabricType
        self.description = description
        self.imageURLs = imageURLs
    }
}

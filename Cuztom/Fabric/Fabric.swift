//
//  Fabric.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

import Foundation
import UIKit

class Fabric: Hashable {
    let uid: String
    let type: String
    let images: [UIImage]
    
    init(uid: String = UUID().uuidString, type: String, images: [UIImage]) {
        self.uid = uid
        self.type = type
        self.images = images
    }
}

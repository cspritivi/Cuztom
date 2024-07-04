//
//  Customer.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import UIKit

class Customer: NSObject {
    var name: String;
    var address: String;
    var phoneNumber: Int;
    
    init(name: String, address: String, phoneNumber: Int) {
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
    }
    
    
}

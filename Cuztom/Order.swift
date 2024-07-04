//
//  Order.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import Foundation

class Order: NSObject {
    
    let id: Int;
    var customer: Customer;
    
    
    init(id: Int, customer: Customer) {
        self.id = id;
        self.customer = customer;
    }
}

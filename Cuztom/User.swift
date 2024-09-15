//
//  User.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/25/24.
//

import Foundation

class User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    var measurements: [CMeasurement]?
    
    init(id: String, fullName: String, email: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
    }
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Kobe Bryant", email: "example@example.com")
}

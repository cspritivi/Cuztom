//
//  AuthViewModel.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/20/24.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var customer: Customer? = nil
    
    func signin(_ email: String, _ password: String) {
        isAuthenticated = true
    }
    
    func signup(_ email: String, _ fullname: String, _ password : String, _ confirmPassword: String) {
        isAuthenticated = true
    }
}

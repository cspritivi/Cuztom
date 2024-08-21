//
//  AuthViewModel.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/20/24.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticated = false
    
    func signin() {
        isAuthenticated.toggle()
        objectWillChange.send()
    }
    
    func signup() {
        isAuthenticated = true
    }
}

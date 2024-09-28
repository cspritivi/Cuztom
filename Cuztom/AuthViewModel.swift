//
//  AuthViewModel.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/20/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
//    func signIn(withEmail email: String, password: String) async throws {
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            await fetchUser()
//        } catch {
//            print("DEBUG: Failed to sign in user with error: \(error.localizedDescription)")
//        }
//    }
    
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult {
        return try await withUnsafeThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                } else {
                    continuation.resume(throwing: NSError(domain: "Auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown authentication error"]))
                }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await signIn(withEmail: email, password: password)
                DispatchQueue.main.async {
                    self.userSession = authResult.user
                    self.errorMessage = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func signUp(withEmail email: String, fullName: String, password : String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.userSession = nil
        } catch {
            print("DEBUG: Failed to logout user with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
        //TODO
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}

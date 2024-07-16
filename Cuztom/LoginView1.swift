//
//  LoginView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import SwiftUI

struct LoginView1: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        
//        NavigationStack(path: $path) {
//            
//            VStack {
//                Image("fullFormLogo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 500, height: 400)
//                
//                Button("Create A New Account") {
//                    path.append("New Account")
//                }
//                .padding(10)
//                .buttonStyle(.bordered)
//                
//                Button("Sign In With An Existing Account"){
//                    path.append("Login")
//                }
//                .buttonStyle(.bordered)
//                
//            }
//        }
//        .navigationDestination(for: String.self) { dest in
//            switch dest {
//            case "New Account": CreateAccountView()
//            case "Login": SignInView()
//            default: CreateAccountView()
//            }
//        }
        
        
        NavigationStack() {
            VStack {
                Image("fullFormLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 400)
                

                
                Button {
                    print("Going to sign in")
                } label: {
                    Text("Sign In")
                }
                .buttonStyle(.bordered)
                .padding(10)
                
                Button {
                    print("Going to sign up")
                } label: {
                    Text("Sign up")
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                


            }
        }
    }
    
}

#Preview {
    LoginView1()
}

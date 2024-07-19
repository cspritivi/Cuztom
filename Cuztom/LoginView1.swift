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
                        .font(.custom("Aileron-Thin", size: 25))
                        .frame(width: UIScreen.main.bounds.size.width * 0.75)
                }
                .buttonStyle(.bordered)
                .padding(10)
                
                Button {
                    print("Going to sign up")
                } label: {
                    Text("Sign up")
                        .font(.custom("Aileron-Thin", size: 25))
                        .frame(width: UIScreen.main.bounds.size.width * 0.75)
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button {
                    print("Preview App")
                } label: {
                    Text("Sign Up Later")
                        .font(.custom("Aileron-Regular", size: 18))
                }
                
                
                

            }
        }
    }
    
}

#Preview {
    LoginView1()
}

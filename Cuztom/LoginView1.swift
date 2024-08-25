//
//  LoginView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import SwiftUI

struct LoginView1: View {
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Image("fullFormLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.5,
                           height: 200)
                    .padding(.bottom, 100)
                    .padding(.top, 44)
                
                NavigationLink {
                    SignInView()
                } label: {
                    Text("SIGN IN")
                        .font(.custom("Aileron-Thin", size: 24))
                        .frame(width: UIScreen.main.bounds.size.width * 0.75,
                               height: 40)
                }
                .buttonStyle(.bordered)
                .padding(10)
                
                NavigationLink {
                    CreateAccountView()
                } label: {
                    Text("CREATE A NEW ACCOUNT")
                        .font(.custom("Aileron-Thin", size: 24))
                        .frame(width: UIScreen.main.bounds.size.width * 0.75,
                               height: 40)
                }
                .buttonStyle(.bordered)
                .padding(10)
                
                Spacer()
                
                Button {
                    print("Preview App")
                } label: {
                    Text("SIGN UP LATER")
                        .font(.custom("Aileron-Regular", size: 15))
                }
            }
            .foregroundStyle(Color(.black))
        }
    }
    
}

#Preview {
    LoginView1()
        .environmentObject(AuthViewModel())
}

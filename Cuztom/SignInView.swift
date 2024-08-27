//
//  SignInView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/7/24.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Image("fullFormLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.5,
                           height: 200)
                
                Text("LOGIN TO YOUR ACCOUNT")
                    .font(.custom("Aileron-Thin", size: 30))
                
                
                //Form Fields
                VStack {
                    InputView(text: $email,
                              title: "EMAIL ADDRESS",
                              placeholder: "ENTER YOUR EMAIL ADDRESS")
                    .textInputAutocapitalization(.never)
                    
                    InputView(text: $password,
                              title: "PASSWORD",
                              placeholder: "ENTER YOUR PASSWORD",
                              isSecureField: true)
                    
                    Button  {
                        Task {
                            try await authViewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .font(.custom("Aileron-Regular", size: 15))
                            Image(systemName: "arrow.right")
                        }
                        .foregroundStyle(Color(.black))
                        .frame(width: UIScreen.main.bounds.size.width * 0.85,
                               height: 20)
                        
                    }
//                    .background(Color(.systemGray6))
//                    .padding(.top, 24)
                    .buttonStyle(.bordered)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    
//                    Text("\(authViewModel.isAuthenticated)")
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 15)
                
                Spacer()
                
                NavigationLink {
                    CreateAccountView()
                } label: {
                    HStack (spacing: 3) {
                        Text("DON'T HAVE AN ACCOUNT?")
                            .font(.custom("Aileron-Thin", size: 15))
//                            .foregroundStyle(Color(.black))
                        Text("SIGN UP")
                            .font(.custom("Aileron-Regular", size: 15))
//                            .foregroundStyle(Color(.black))
                    }
                    .foregroundStyle(Color(.black))
                }
            }
        }
//        .navigationBarBackButtonHidden()
    }
}

extension SignInView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return email.contains("@")
        && password.count > 5
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}

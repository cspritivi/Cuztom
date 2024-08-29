//
//  CreateAccountView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/7/24.
//

import SwiftUI

struct CreateAccountView: View {
    
    //This stuff needs to go in the viewModel
    
    @State private var fullName:String = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("fullFormLogo")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.5,
                       height: 200)
                .accessibilityIdentifier("logo")
            
            Text("CREATE A NEW ACCOUNT")
                .font(.custom("Aileron-Thin", size: 30))
            
            VStack {
                
                InputView(text: $fullName,
                          title: "NAME",
                          placeholder: "ENTER YOUR NAME")
                .textInputAutocapitalization(.words)
                
                InputView(text: $email,
                          title: "EMAIL",
                          placeholder: "ENTER YOUR EMAIL ADDRESS")
                .textInputAutocapitalization(.never)
                
                InputView(text: $password,
                          title: "PASSWORD",
                          placeholder: "ENTER YOUR PASSWORD",
                          isSecureField: true)
                .textContentType(.oneTimeCode)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword, 
                              title: "CONFIRM PASSWORD",
                              placeholder: "ENTER YOUR PASSWORD AGAIN",
                              isSecureField: true)
                    .textContentType(.oneTimeCode)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.gray))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.gray))
                        }
                    }
                }
                
                Button  {
                    Task {
                        try await authViewModel.signUp(withEmail: email,
                                                       fullName: fullName,
                                                       password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .font(.custom("Aileron-Regular", size: 15))
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.size.width * 0.85,
                           height: 20)
                    
                }
                .background(Color(.systemGray6))
//                .padding(.top, 24)
                .buttonStyle(.bordered)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .accessibilityIdentifier("sign up button")
            }
            .padding(.horizontal)
            .padding(.top, 15)
                
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack(spacing: 3){
                    Text("WANT TO BROWSE?")
                        .font(.custom("Aileron-Thin", size: 15))
                    Text("SIGN UP LATER")
                        .font(.custom("Aileron-Regular", size: 15))
                }
                .foregroundStyle(Color(.black))
            })
            
        }
    }
}

extension CreateAccountView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !fullName.isEmpty
        && email.contains("@")
        && password.count > 5
        && password == confirmPassword
    }
}

#Preview {
    CreateAccountView()
        .environmentObject(AuthViewModel())
}

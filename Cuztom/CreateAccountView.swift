//
//  CreateAccountView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/7/24.
//

import SwiftUI

struct CreateAccountView: View {
    
    //This stuff needs to go in the viewModel
    
    @State private var fullname:String = ""
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
            
            Text("CREATE A NEW ACCOUNT")
                .font(.custom("Aileron-Thin", size: 30))
            
            VStack(spacing:24) {
                
                InputView(text: $fullname,
                          title: "NAME",
                          placeholder: "ENTER YOUR NAME")
                
                InputView(text: $email,
                          title: "EMAIL",
                          placeholder: "ENTER YOUR EMAIL ADDRESS")
                
                InputView(text: $password,
                          title: "PASSWORD",
                          placeholder: "ENTER YOUR PASSWORD",
                          isSecureField: true)
                
                InputView(text: $confirmPassword, 
                          title: "CONFIRM PASSWORD",
                          placeholder: "ENTER YOUR PASSWORD AGAIN",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 15)
            
            Button  {
                print("Signing up...")
                authViewModel.signup(fullname, email, password, confirmPassword)
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
            .padding(.top, 24)
            .buttonStyle(.bordered)
                
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

#Preview {
    CreateAccountView()
        .environmentObject(AuthViewModel())
}

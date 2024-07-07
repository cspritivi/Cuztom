//
//  LoginView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import SwiftUI

struct LoginView1: View {
    var body: some View {
        VStack {
            Image("fullFormLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 400)
            
            Button("Create A New Account") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .padding(10)
            .buttonStyle(.bordered)
            
            Button("Sign In With An Existing Account"){
                
            }
            .buttonStyle(.bordered)
            
        }
    }
}

#Preview {
    LoginView1()
}

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
                    .frame(width: UIScreen.main.bounds.size.width * 0.50,
                           height: 200)
                    .padding(.bottom, 100)
                
                
                Button {
                    print("Going to sign in")
                } label: {
                    Text("SIGN IN")
                        .font(.custom("Aileron-Thin", size: 24))
                        .frame(width: UIScreen.main.bounds.size.width * 0.75,
                               height: 40)
                }
                .buttonStyle(.bordered)
//                .foregroundStyle(Color(.black))
                .padding(10)
                
                Button {
                    print("Going to sign up")
                } label: {
                    Text("CREATE A NEW ACCOUNT")
                        .font(.custom("Aileron-Thin", size: 24))
                        .frame(width: UIScreen.main.bounds.size.width * 0.75,
                               height: 40)
                }
                .buttonStyle(.bordered)
//                .foregroundStyle(Color(.black))
                
                Spacer()
                
                Button {
                    print("Preview App")
                } label: {
                    Text("SIGN UP LATER")
                        .font(.custom("Aileron-Regular", size: 15))
                }
//                .foregroundStyle(Color(.black))
                
                
                

            }
            .foregroundStyle(Color(.black))
        }
    }
    
}

#Preview {
    LoginView1()
}

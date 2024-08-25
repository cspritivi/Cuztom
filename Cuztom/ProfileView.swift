//
//  ProfileView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import SwiftUI


struct ProfileView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    var body: some View {
        List {
            Section {
                HStack {
                    Text("MJ")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.black))
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Micheal Jordan")
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text("example@example.com")
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                }
            }
            
            Section("General") {
                
            }
            
            Section("Accent") {
                
                
            }
        }
        
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}

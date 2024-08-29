//
//  ProfileView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/4/24.
//

import SwiftUI


struct ProfileView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var settings: [SettingsRowView] = []
    
    var body: some View {
        if let user = authViewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.white))
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                                .accessibilityIdentifier("fullname")
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(Color(.gray))
                                .accessibilityIdentifier("email")
                        }
                    }
                }
                
                Section("Clothing") {
                    NavigationStack {
                            NavigationLink(destination: MeasurementView(), label : {
                                SettingsRowView(imageName: "pencil.and.list.clipboard", title: "Measurements", tint: Color(.blue))
                            })
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tint: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(Color(.gray))
                    }
                    
                    
                }
                
                Section("Account") {
                    
                    Button {
                        authViewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tint: Color(.red))
                    }
                    .accessibilityIdentifier("sign out button")
                    
                    Button {
                        print("delete account")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tint: Color(.red))
                    }
                    .accessibilityIdentifier("delete account button")
                    
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}

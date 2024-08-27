//
//  InputView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 7/19/24.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false

    var body: some View {
        
        VStack(alignment: .leading, spacing: 12, content: {
            Text(title)
                .foregroundStyle(Color.primary)
                .font(.custom("Aileron-Regular", size: 15))
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.custom("Aileron-Regular", size: 14))
                    .accessibilityIdentifier("\(title.lowercased())")
            } else {
                TextField(placeholder, text: $text)
                    .font(.custom("Aileron-Regular", size: 14))
                    .accessibilityIdentifier("\(title.lowercased())")
            }
            
            Divider()
                .padding(.bottom, 24)
        })
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "example@mail.com")
}

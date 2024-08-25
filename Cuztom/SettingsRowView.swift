//
//  SettingsRowView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/25/24.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName: String
    let title: String
    let tint: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tint)
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color(.black))
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tint: Color(.systemGray))
}

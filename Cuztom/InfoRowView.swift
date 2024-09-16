//
//  InfoRowView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/16/24.
//

import SwiftUI

struct InfoRowView: View {
    let title: String
    let tint: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color(.black))
        }
    }
}

#Preview {
    InfoRowView(title: "Version", tint: Color(.systemGray))
}


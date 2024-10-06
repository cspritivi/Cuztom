//
//  OrderTypeRowView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 10/5/24.
//

import SwiftUI

struct OrderTypeRowView: View {
    let type: String
    let image: UIImage
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 2/3)
                    .clipped()
                
                Text(type.uppercased())
                    .font(.system(size: 24))
                    .frame(width: geometry.size.width * 1/3)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 4)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    VStack {
        OrderTypeRowView(type: "Suit", image: UIImage(systemName: "tshirt")!)
        OrderTypeRowView(type: "Dress", image: UIImage(systemName: "tshirt")!)
    }
    .padding()
}

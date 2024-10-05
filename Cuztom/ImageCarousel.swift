//
//  ImageCarousel.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 10/3/24.
//


import SwiftUI

struct ImageCarousel: View {
    let images: [UIImage]
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(uiImage: images[index])
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
            
            HStack(spacing: 8) {
                ForEach(0..<images.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarousel(images: [UIImage(systemName: "square.and.arrow.up")!, UIImage(systemName: "square.and.arrow.down.on.square.fill")!, UIImage(systemName: "pencil")!, UIImage(systemName: "eraser")!])
    }
}

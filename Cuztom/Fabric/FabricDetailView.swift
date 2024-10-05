//
//  FabricDetailView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

//import SwiftUI
//
//struct FabricDetailView: View {
//    
//    let fabric: Fabric
//    @ObservedObject var fabricViewModel: FabricViewModel
//    @State var imageURLs: [URL]?
//    
//    var body: some View {
//        
//        Group {
//            VStack(alignment: .leading, spacing: 40) {
//                ScrollView(.horizontal, showsIndicators: false) {
//
//                }
//            }
//        }
//        .navigationTitle(fabric.id)
//        .navigationBarTitleDisplayMode(.inline)
//        .task {
//            self.imageURLs = await fabricViewModel.loadImageURLs(for: fabric)
//        }
//        
//        
//        
//        ScrollView {
//                    VStack(alignment: .leading, spacing: 20) {
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 15) {
//                                ForEach(fabric.imageURLs, id: \.self) { imageName in
////                                    Image(uiImage: imageName) // Use AsyncImage for remote URLs
////                                        .resizable()
////                                        .scaledToFill()
////                                        .frame(width: 200, height: 200)
////                                        .clipped()
////                                        .cornerRadius(10)
//                                    Text(imageName)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                        
//                        VStack(alignment: .leading, spacing: 10) {
//                            Text(fabric.id)
//                                .font(.title)
//                                .fontWeight(.bold)
//                            
//                            Text(fabric.fabricType)
//                                .font(.body)
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//                .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//struct FabricDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleFabric = Fabric(
//            id: "10",
//            fabricType: "Cotton",
//            description: "020",
//            imageURLs: [
//                "fabric_images/Cotton/10/im_1.png",
//                "fabric_images/Cotton/10/im_2.png",
//                "fabric_images/Cotton/10/im_3.png",
//                "fabric_images/Cotton/10/im_4.png"
//            ]
//        )
//        
//        return FabricDetailView(fabric: sampleFabric, fabricViewModel: FabricViewModel())
//    }
//}

import SwiftUI

struct FabricDetailView: View {
    let fabric: Fabric
    @ObservedObject var fabricViewModel: FabricViewModel
    @State var images: [UIImage]?

    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 20) {
                imageSection
                
                
                infoSection
                
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
        }
        .navigationTitle(fabric.id)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.images = await fabricViewModel.loadImages(for: self.fabric)
        }
    }
    
    private var imageSection: some View {
        VStack {
            if fabricViewModel.isLoading {
                ProgressView()
            } else {
                if let images = images {
                    ImageCarousel(images: images)
                        .frame(width: UIScreen.main.bounds.size.width, height: 300)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    ProgressView()
                        .frame(width: 300, height: 300)
                }
            }
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Fabric Type: \(fabric.fabricType)")
                .font(.headline)
            
            Text(fabric.description.isEmpty ? "Fabric has no description right now" : fabric.description)
                .font(.body)
        }
        .padding()
        
    }
}

struct FabricDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            FabricDetailView(fabric: Fabric(
                id: "10",
                fabricType: "Cotton",
                description: "020",
                imageURLs: [
                    "fabric_images/Cotton/10/im_1.png",
                    "fabric_images/Cotton/10/im_2.png",
                    "fabric_images/Cotton/10/im_3.png",
                    "fabric_images/Cotton/10/im_4.png"
                ]
            ), fabricViewModel: FabricViewModel())
        }
    }
}

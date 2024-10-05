import SwiftUI


struct FabricThumbnailView: View {
    let fabric: Fabric
    @ObservedObject var fabricViewModel: FabricViewModel
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            if fabricViewModel.isLoading {
                ProgressView()
            } else if let errorMessage = fabricViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color(.red))
            } else {
                Group {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else { ProgressView() }
                }
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(10)
                
                Text(fabric.id)
                    .font(.caption)
                    .lineLimit(1)
            }
        }
        .task {
            self.image = await fabricViewModel.loadImages(for: self.fabric).randomElement()
        }
    }
}

// Preview
struct FabricThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFabric = Fabric(
            id: "10",
            fabricType: "Cotton",
            description: "020",
            imageURLs: [
                "fabric_images/Cotton/10/im_1.png",
                "fabric_images/Cotton/10/im_2.png",
                "fabric_images/Cotton/10/im_3.png",
                "fabric_images/Cotton/10/im_4.png"
            ]
        )
        
        return FabricThumbnailView(fabric: sampleFabric, fabricViewModel: FabricViewModel())
    }
}

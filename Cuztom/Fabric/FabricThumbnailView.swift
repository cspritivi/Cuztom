import SwiftUI

struct FabricThumbnailView: View {
    let fabric: Fabric
    @ObservedObject var fabricViewModel: FabricViewModel
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            Group {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "questionmark.app.fill")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 80, height: 80)
            .clipped()
            .cornerRadius(10)
            
            Text(fabric.id)
                .font(.caption)
                .lineLimit(1)
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        if let firstURL = fabric.imageURLs.first,
           let loadedImage = await fabricViewModel.loadImage(url: firstURL) {
            self.image = loadedImage
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

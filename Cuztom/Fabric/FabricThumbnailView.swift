import SwiftUI


struct FabricThumbnailView: View {
    let fabric: Fabric
    @ObservedObject var fabricViewModel: FabricViewModel
    @State private var imageURL: URL?
    
    var body: some View {
        VStack {
            if fabricViewModel.isLoading {
                ProgressView()
            } else if let errorMessage = fabricViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color(.red))
            } else {
                Group {
                    if let imageURL = imageURL {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure:
                                Image(systemName: "photo")
                                    .foregroundStyle(Color(.gray))
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        ProgressView() }
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
            self.imageURL = await fabricViewModel.loadImageURLs(for: self.fabric).first
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

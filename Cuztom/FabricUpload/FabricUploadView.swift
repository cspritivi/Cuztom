//
//  FabricUploadView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/25/24.
//

import SwiftUI

struct FabricUploadView: View {
    
    @State private var viewModel = FabricUploadViewController()
    
    var body: some View {
        VStack {
            Button("Upload Fabrics") {
                viewModel.uploadFabrics()
            }
            .disabled(viewModel.isUploading)
            
            if viewModel.isUploading {
                ProgressView(value: viewModel.progress) {
                    Text("Uploading... \(Int(viewModel.progress * 100))%")
                }
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color(.red))
                    .padding()
            }
            
            if viewModel.progress == 1.0 && !viewModel.isUploading {
                Text("Upload Completed Successfully")
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    FabricUploadView()
}

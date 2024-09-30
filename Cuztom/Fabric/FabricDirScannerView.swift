//
//  FabricDirScannerView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/29/24.
//

import SwiftUI

struct FabricDirScannerView: View {
    @State private var isScanning = false
    @State private var scanResult: String?
    
    var body: some View {
        VStack {
            Button("Scan and Upload Fabrics") {
                isScanning = true
                scanResult = nil
                let scanner = FabricDirectoryScanner()
                scanner.scanAndUpload { result in
                    isScanning = false
                    switch result {
                    case .success:
                        scanResult = "Scan and upload completed successfully!"
                    case .failure(let error):
                        scanResult = "Error: \(error.localizedDescription)"
                    }
                }
            }
            .disabled(isScanning)
            
            if isScanning {
                ProgressView()
            }
            
            if let result = scanResult {
                Text(result)
            }
        }
    }
}

#Preview {
    FabricDirScannerView()
}

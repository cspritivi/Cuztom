//
//  FabricUploadViewController.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/25/24.
//

import Foundation
import SwiftUI
import Combine
import UniformTypeIdentifiers

class FabricUploadViewController {
    @Published var isUploading = false
    @Published var progress = 0.0
    @Published var errorMessage: String?
//    @Published var selectedFolderURL: URL?
    
    private let uploader = FabricUploader()
    
//    func selectFolder() {
//        let openPanel = NSOpen
//        openPanel.allowsMultipleSelection = false
//        openPanel.canChooseDirectories = true
//    }
    
    func uploadFabrics() {
        isUploading = true
        progress = 0.0
        errorMessage = nil
        
        DispatchQueue.global(qos: .background).async {
            let fabricsFolderPath = self.getFabricsFolderPath()
            
            self.uploader.processAndUploadFabrics(fromDirectory: fabricsFolderPath) { currentProgress in
                DispatchQueue.main.async {
                    self.progress = currentProgress
                }
            } completion: { error in
                DispatchQueue.main.async {
                    self.isUploading = false
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    } else {
                        self.progress = 1.0
                    }
                }
                
            }
        }
    }
    
    func getFabricsFolderPath() -> String {
        return "/Users/pritivischhabria/Desktop/Fabrics Image Set/Fabrics"
    }
    
}

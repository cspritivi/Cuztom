//
//  FabricViewModal.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/22/24.
//

import Foundation
import UIKit

class FabricViewModal {
    
    static func fetchAllFabrics() async throws -> [Fabric]? {
        var fabrics: [Fabric] = []
        
        guard let fabricsFolder = Bundle.main.url(forResource: "Linen", withExtension: nil) else {
            print("No Fabrics Found")
            return nil
        }
        
        do {
            let fabricFolderURLs = try FileManager.default.contentsOfDirectory(at: fabricsFolder, includingPropertiesForKeys: nil)
            
            for fabricFolderURL in fabricFolderURLs {
                let id = fabricFolderURL.lastPathComponent
                
                let imageURLs = try FileManager.default.contentsOfDirectory(at: fabricFolderURL, includingPropertiesForKeys: nil)
                    .filter { $0.lastPathComponent.hasPrefix("im") }
                
                let images = imageURLs.compactMap { UIImage(contentsOfFile: $0.path()) }
                
                let metaDataURL = fabricFolderURL.appendingPathComponent("tag.txt")
                guard let metaDataContent = try? String(contentsOf: metaDataURL) else {
                    print("Failed to load metadata for \(id)")
                    continue
                }
                
                let type = extractType(from: metaDataContent)
                let fabric = Fabric(uid: id, type: type, images: images)
                
                fabrics.append(fabric)
                
            }
        } catch {
            print("Error loading fabric: \(error.localizedDescription)")
        }
        return fabrics
    }
    
    private static func extractType(from metadata: String) -> String {
        let lines = metadata.components(separatedBy: .newlines)
        guard lines.count >= 2 else { return "Unknown" }
        let typesLine = lines[1]
        let firstType = typesLine.components(separatedBy: " ").first ?? "Unknown"
        return firstType
    }
}

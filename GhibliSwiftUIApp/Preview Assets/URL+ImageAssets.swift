//
//  URL+ImageAssets.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/28/26.
//
import UIKit

//+ is usually used for extensions


/// Retrieves (or creates should it be necessary) a temporary image's local URL on cash directory for testing purposes
/// Parameter name: image name retrieves from asset catalog
/// Parameter extension: Image type. Defaults `.jpg` kind
/// Return : Resulting URL for named image
/// 
extension URL {
    static func convertAssetImage(named name: String, extension: String = "jpg") -> URL? {
        // loads image internally(from assets)
        let fileManager = FileManager.default
        
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let url = cacheDirectory.appendingPathComponent("\(name).\(`extension`)")
        guard !fileManager.fileExists(atPath: url.path) else {
            return url
        }
        
        guard let image = UIImage(named: name), //getting image from the assets
              let data = image.jpegData(compressionQuality: 1) else {  //converting to data
            return nil
        }
        
        fileManager.createFile(atPath: url.path, contents: data, attributes: nil) //and saving it
        return url
    }
}

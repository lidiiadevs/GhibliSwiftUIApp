//
//  FilmImageView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/23/26.
//

import SwiftUI

struct FilmImageView: View {
    var url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL) {
        self.url = url
    } // u can use one of the inits - URL or a String
    
    var body: some View {
        //AsyncImage(url: URL(string: film.bannerImage))
        AsyncImage(url: url) {
            phase in
            switch phase {
            case .empty:
                Color(white: 0.8)
                    .overlay{
                        Image(systemName: "photo")
//                        ProgressView()
//                            .controlSize(.regular)
            }
                    
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(let error):
                Text("Could not get image")
            @unknown default:
                fatalError()
            }
        }
        //.frame(height: 200)
    //    .clipped()//for .scaledToFill
    }
}

#Preview {
    let name = "bannerImage"
    let url = AssetExtractor().createLocalUrl(forImageNamed: name)
        
    
    FilmImageView(url: url!)
        .frame(height: 150)
//    FilmImageView(urlPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
}


//TODO: - decide where this should live
class AssetExtractor {
    /// - Parameter name: image name retrieved from asset catalog
    /// - Parameter imageExtension: Image type. Defaults to `.jpg` kind
    /// - Returns: Resulting URL for named image
    func createLocalUrl(forImageNamed name: String, imageExtension: String = "jpg") -> URL? {
        let fileManager = FileManager.default

        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            print("Unable to access cache directory")
            return nil
        }

        let url = cacheDirectory.appendingPathComponent("\(name).\(imageExtension)")

        // If file doesn't exist, creates it
        guard fileManager.fileExists(atPath: url.path) else {
            // Bundle(for: Self.self) is used here instead of .main in order to work on test target as well
            guard let image = UIImage(named: name, in: Bundle(for: Self.self), with: nil),
                  let data = image.jpegData(compressionQuality: 1) else {
                print("Impossible to convert to jpg data")
                return nil
            }

            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }

        return url
    }
}

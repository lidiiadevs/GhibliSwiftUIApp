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

#Preview("Poster Image") {
    FilmImageView(url: URL.convertAssetImage(named: "posterImage")!)
        .frame(height: 150)
}



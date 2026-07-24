//
//  FilmImageView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/23/26.
//

import SwiftUI

struct FilmImageView: View {
    var urlPath: String
    
    var body: some View {
        //AsyncImage(url: URL(string: film.bannerImage))
        AsyncImage(url: URL(string: urlPath)) {
            phase in
            switch phase {
            case .empty:
                Color.gray
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(let error):
                Text("Could not get image")
            @unknown default:
                fatalError()
            }
        }
        .frame(height: 200)
    //    .clipped()//for .scaledToFill
    }
}

#Preview {
    FilmImageView(urlPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
}

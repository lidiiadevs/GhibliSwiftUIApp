//
//  SearchScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/29/26.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchScreen()
}

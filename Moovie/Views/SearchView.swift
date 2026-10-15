//
//  SearchView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 15/10/2026.
//

import SwiftUI

struct SearchView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchView()
}

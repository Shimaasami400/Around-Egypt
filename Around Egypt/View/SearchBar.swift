//
//  SearchBar.swift
//  Around Egypt
//
//  Created by Shimaa on 10/12/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            
            TextField("Try “Luxor”", text: $searchText, onCommit: {
                onSearch()
            })
            .padding(8)
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

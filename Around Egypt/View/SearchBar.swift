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
                    .padding(.leading, 12)
                
                TextField("Try \"Luxor\"", text: $searchText)
                    .padding(.vertical, 8)
                    .font(.custom("Gotham", size: 17))
            }
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }

    #Preview {
        @State var searchText = ""
        return SearchBar(searchText: .constant(searchText), onSearch: {
            print("Preview search triggered.")
        })
    }

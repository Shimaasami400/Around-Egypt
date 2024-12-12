//
//  MostRecentCardView.swift
//  Around Egypt
//
//  Created by Shimaa on 12/12/2024.
//

import SwiftUI

struct MostRecentCardView: View {
    let experience: Experience
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                
                AsyncImage(url: URL(string: experience.coverPhoto)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 339, height: 154)
                .cornerRadius(10)
                .clipped()
                
                Image("360")
                    .resizable()
                    .frame(width: 37, height: 37)
                    .padding(.top, 80)
                    .padding(.leading, 150)
                
                Image("info")
                    .clipShape(Circle())
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .padding(.vertical, 6)
                    .padding(.leading, 300)
                
                HStack(spacing: 8) {
                    Image("eye")
                        .frame(width: 20, height: 25)
                    Text("\(experience.viewsNo)")
                        .foregroundColor(.white)
                        .font(.custom("Gotham", size: 14))
                        .fontWeight(.bold)
                    Image("multiple pictures")
                        .frame(width: 20, height: 16)
                        .padding(.leading, 235)
                    
                }
                .padding(6)
                .padding(.top, 120)
                .padding(.leading, 8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Text(experience.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    HStack {
                        Spacer()
                        HStack(spacing: 4) {
                            Text("\(experience.likesNo)")
                                .font(.subheadline)
                            Image("heart")
                                .foregroundColor(.orange)
                        }
                    }.padding(.bottom, 4)
                }
            }
            .padding(.horizontal, 8)
        }
        .frame(width: 339)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

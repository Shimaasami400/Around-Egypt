//
//  ExperienceCardView.swift
//  Around Egypt
//
//  Created by Shimaa on 10/12/2024.
//

import SwiftUI
import Kingfisher

struct ExperienceCardView: View {
    @ObservedObject var viewModel: ExperienceViewModel
    let experience: Experience
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: URL(string: experience.coverPhoto)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .onTapGesture {
                            isSheetPresented = true
                        }
                } placeholder: {
                    Color.gray
                }
                .frame(width: 339, height: 154)
                .cornerRadius(10)
                .clipped()
                
                if experience.isRecommended {
                    HStack(spacing: 4) {
                        Image("star")
                            .resizable()
                            .frame(width: 14, height: 14)
                        Text("RECOMMENDED")
                            .font(.custom("Gotham", size: 12))
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)
                    .padding(8)
                }
                
                Image("360")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.top, 60)
                    .padding(.leading, 150)
                
                Image("info")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.vertical, 6)
                    .padding(.leading, 300)
                
                HStack(spacing: 8) {
                    Image("eye")
                        .frame(width: 20, height: 25)
                    Text("\(experience.viewsNo)")
                        .foregroundColor(.white)
                        .font(.custom("Gotham", size: 14))
                        .fontWeight(.bold)
                    Spacer()
                    Image("multiple pictures")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(8)
                .padding(.horizontal, 8)
                .padding(.top, 120)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(experience.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("\(experience.likesNo)")
                            .font(.subheadline)
                        
                        Image(systemName: experience.liked ?? false ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.orange)
                            .onTapGesture {
                                if !(experience.liked ?? false) {
                                    viewModel.likeExperience(id: experience.id)
                                }
                            }
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .frame(width: 339)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
        .sheet(isPresented: $isSheetPresented) {
            ExperienceDetailsView(experience: experience)
        }
    }
}

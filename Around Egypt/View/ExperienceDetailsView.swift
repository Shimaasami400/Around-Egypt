//
//  ExperienceDetailsView.swift
//  Around Egypt
//
//  Created by Shimaa on 13/12/2024.
//

import SwiftUI

struct ExperienceDetailsView: View {
    let experience: Experience

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: experience.coverPhoto)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 500)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }

                    // Views Overlay
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

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(experience.title)
                            .font(.title3)
                            .bold()

                        Text("\(experience.city?.name ?? ""), Egypt.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.orange)
                        Text("\(experience.likesNo)")
                            .font(.footnote)
                    }
                }
                .padding(.horizontal, 16)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                        .padding(.bottom, 4)

                    Text(experience.description)
                        .font(.body)
                        .lineSpacing(4)
                }
                .padding()
            }
            .padding(.bottom, 16)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }
}

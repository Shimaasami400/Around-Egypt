//
//  ContentView.swift
//  Around Egypt
//
//  Created by Shimaa on 10/12/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = ExperienceViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        SearchBar(searchText: $viewModel.searchText, onSearch: {
                            viewModel.searchExperiences()
                        })
                    }
                    .padding()
                    if !viewModel.searchText.isEmpty {
                        if viewModel.isLoading {
                            ProgressView("Loading Search Results...")
                                .padding()
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            Text("Search Results")
                                .font(.custom("Gotham", size: 22))
                                .bold()
                                .padding(.horizontal)
                            
                            ForEach(viewModel.searchResults) { experience in
                                ExperienceCardView(viewModel: viewModel, experience: experience)
                            }
                        }
                    } else {
                        
                        if viewModel.isLoading {
                            ProgressView("Loading Recommended Experiences...")
                                .padding()
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome!")
                                    .bold()
                                    .font(.custom("GothamRounded", size: 22))
                                
                                Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                                    .bold()
                                    .font(.custom("Gotham", size: 14))
                            }
                            .padding(.horizontal)
                            
                            Spacer(minLength: 20)
                            
                            if viewModel.isLoading {
                                ProgressView("Loading Recommended Experiences...")
                                    .padding()
                            } else if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            } else {
                                
                                Text("Recommended Experiences")
                                    .font(.custom("Gotham", size: 22))
                                    .bold()
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.recommendedExperiences) { experience in
                                            ExperienceCardView(viewModel: viewModel, experience: experience)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            Spacer()
                            Spacer()
                            
                            if !viewModel.mostRecentExperiences.isEmpty {
                                Text("Most Recent")
                                    .font(.custom("Gotham", size: 22))
                                    .bold()
                                
                                VStack(spacing: 16) {
                                    ForEach(viewModel.mostRecentExperiences) { experience in
                                        MostRecentCardView(experience: experience)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

//
//  ExperienceViewModel.swift
//  Around Egypt
//
//  Created by Shimaa on 12/12/2024.
//

import Foundation
import Combine

class ExperienceViewModel: ObservableObject {
    @Published var recommendedExperiences: [Experience] = []
    @Published var mostRecentExperiences: [Experience] = []
    @Published var searchResults: [Experience] = []
    @Published var selectedExperience: Experience? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                fetchRecommendedExperiences()
            }
        }
    }
    
    private let networkService: ExperienceServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: ExperienceServiceProtocol = ExperienceNetworkService()) {
        self.networkService = networkService
        fetchRecommendedExperiences()
        fetchMostRecentExperiences()
    }
    
    func fetchRecommendedExperiences() {
        isLoading = true
        errorMessage = nil
        networkService.fetchRecommendedExperiences()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] experiences in
                self?.recommendedExperiences = experiences
            }
            .store(in: &cancellables)
    }
    
    func fetchMostRecentExperiences() {
        isLoading = true
        errorMessage = nil
        networkService.fetchMostRecentExperiences()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] experiences in
                self?.mostRecentExperiences = experiences
            }
            .store(in: &cancellables)
    }
    
    func searchExperiences() {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        networkService.searchExperiences(with: searchText)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] experiences in
                self?.searchResults = experiences
            }
            .store(in: &cancellables)
    }
    
    func fetchExperienceDetails(for id: String) {
        isLoading = true
        errorMessage = nil
        networkService.fetchExperienceDetails(for: id)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] experience in
                self?.selectedExperience = experience
            }
            .store(in: &cancellables)
    }
}

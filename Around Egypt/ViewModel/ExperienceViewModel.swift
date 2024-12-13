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
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] experiences in
                self?.recommendedExperiences = experiences.map { exp in
                    var mutableExp = exp
                    mutableExp.liked = UserDefaults.standard.likedExperiences.contains(exp.id)
                    return mutableExp
                }
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

    
    func likeExperience(id: String) {
        guard let index = recommendedExperiences.firstIndex(where: { $0.id == id }) else { return }
        
        recommendedExperiences[index].liked = true
        recommendedExperiences[index].likesNo += 1
        
        if !UserDefaults.standard.likedExperiences.contains(id) {
            UserDefaults.standard.likedExperiences.insert(id)
        }
        
        networkService.likeExperience(id: id)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Failed to like experience: \(error.localizedDescription)")
                    
                    if !UserDefaults.standard.likedExperiences.contains(id) {
                        UserDefaults.standard.likedExperiences.insert(id)
                    }
                    
                    self.recommendedExperiences[index].liked = false
                    self.recommendedExperiences[index].likesNo -= 1
                }
            } receiveValue: { [weak self] newLikesCount in
                self?.recommendedExperiences[index].likesNo = newLikesCount
                self?.recommendedExperiences[index].liked = true
            }
            .store(in: &cancellables)
    }
}

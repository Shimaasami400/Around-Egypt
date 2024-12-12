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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let networkService: ExperienceServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkService: ExperienceServiceProtocol = ExperienceNetworkService()) {
        self.networkService = networkService
        fetchRecommendedExperiences()
    }

    func fetchRecommendedExperiences() {
        isLoading = true
        errorMessage = nil

        networkService.fetchRecommendedExperiences()
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] experiences in
                self?.recommendedExperiences = experiences
            }
            .store(in: &cancellables)
    }
}

//
//  MockExperienceNetworkService.swift
//  Around EgyptTests
//
//  Created by Shimaa on 13/12/2024.
//

import Foundation
import Combine
@testable import Around_Egypt

class MockExperienceNetworkService: ExperienceServiceProtocol {
    
    var shouldReturnError: Bool
    var mockExperiences: [Experience] = []
    var mockExperience: Experience?
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    enum ResponseWithError: Error {
        case responseError
    }
    
    func fetchRecommendedExperiences() -> AnyPublisher<[Experience], Error> {
        if shouldReturnError {
            return Fail(error: ResponseWithError.responseError)
                .eraseToAnyPublisher()
        } else {
            return Just(mockExperiences)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchMostRecentExperiences() -> AnyPublisher<[Experience], Error> {
        if shouldReturnError {
            return Fail(error: ResponseWithError.responseError)
                .eraseToAnyPublisher()
        } else {
            return Just(mockExperiences)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func searchExperiences(with title: String) -> AnyPublisher<[Experience], Error> {
        if shouldReturnError {
            return Fail(error: ResponseWithError.responseError)
                .eraseToAnyPublisher()
        } else {
            return Just(mockExperiences.filter { $0.title.contains(title) })
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchExperienceDetails(for id: String) -> AnyPublisher<Experience, Error> {
        if shouldReturnError {
            return Fail(error: ResponseWithError.responseError)
                .eraseToAnyPublisher()
        } else {
            guard let experience = mockExperience else {
                return Fail(error: ResponseWithError.responseError)
                    .eraseToAnyPublisher()
            }
            return Just(experience)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func likeExperience(id: String) -> AnyPublisher<Int, Error> {
        if shouldReturnError {
            return Fail(error: ResponseWithError.responseError)
                .eraseToAnyPublisher()
        } else {
            return Just(1)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

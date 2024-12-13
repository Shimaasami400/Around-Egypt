//
//  MockExperienceNetworkServiceTests.swift
//  Around EgyptTests
//
//  Created by Shimaa on 13/12/2024.
//

import XCTest
@testable import Around_Egypt
import Combine

final class MockExperienceNetworkServiceTests: XCTestCase {
    
    var mockService: MockExperienceNetworkService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        mockService = MockExperienceNetworkService(shouldReturnError: false)

        let mockTags = [Tag(id: 1, name: "Adventure"), Tag(id: 2, name: "Culture")]
        let mockCity = City(id: 1, name: "Cairo")
        
        let experience = Experience(
            id: "1",
            title: "Test Experience",
            coverPhoto: "https://example.com/cover.jpg",
            description: "A great experience",
            viewsNo: 100,
            likesNo: 50,
            recommended: 1,
            tags: mockTags,
            city: mockCity,
            liked: true
        )
        
        mockService.mockExperiences = [experience]
        mockService.mockExperience = experience
    }
    
    override func tearDownWithError() throws {
        mockService = nil
        cancellables = []
    }
    
    func testFetchRecommendedExperiences() {
        mockService.fetchRecommendedExperiences()
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success, but got failure.")
                case .finished:
                    break
                }
            } receiveValue: { experiences in
                XCTAssertEqual(experiences.count, 1)
                XCTAssertEqual(experiences.first?.title, "Test Experience")
            }
            .store(in: &cancellables)
    }
    
    func testFetchMostRecentExperiences() {
        mockService.fetchMostRecentExperiences()
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success, but got failure.")
                case .finished:
                    break
                }
            } receiveValue: { experiences in
                XCTAssertEqual(experiences.count, 1)
                XCTAssertEqual(experiences.first?.title, "Test Experience")
            }
            .store(in: &cancellables)
    }
    
    func testSearchExperiences() {
        mockService.searchExperiences(with: "Test")
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success, but got failure.")
                case .finished:
                    break
                }
            } receiveValue: { experiences in
                XCTAssertEqual(experiences.count, 1)
                XCTAssertEqual(experiences.first?.title, "Test Experience")
            }
            .store(in: &cancellables)
    }
    
    func testFetchExperienceDetails() {
        mockService.fetchExperienceDetails(for: "1")
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success, but got failure.")
                case .finished:
                    break
                }
            } receiveValue: { experience in
                XCTAssertEqual(experience.title, "Test Experience")
            }
            .store(in: &cancellables)
    }
    
    func testLikeExperience() {
        mockService.likeExperience(id: "1")
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success, but got failure.")
                case .finished:
                    break
                }
            } receiveValue: { likesCount in
                XCTAssertEqual(likesCount, 1)
            }
            .store(in: &cancellables)
    }
    
    func testFetchRecommendedExperiencesWithError() {
        mockService.shouldReturnError = true
        
        mockService.fetchRecommendedExperiences()
            .sink { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    XCTFail("Expected failure, but got success.")
                }
            } receiveValue: { experiences in
                XCTFail("Expected error, but got experiences.")
            }
            .store(in: &cancellables)
    }
}

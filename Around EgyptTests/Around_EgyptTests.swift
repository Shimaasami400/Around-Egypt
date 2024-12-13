//
//  Around_EgyptTests.swift
//  Around EgyptTests
//
//  Created by Shimaa on 10/12/2024.
//

import XCTest
import Combine
@testable import Around_Egypt

final class Around_EgyptTests: XCTestCase {
    
    var experienceService: ExperienceNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        experienceService = ExperienceNetworkService()
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        experienceService = nil
        cancellables = nil
    }
    
    func testFetchRecommendedExperiences() {
        let expectation = self.expectation(description: "Fetch Recommended Experiences")
        
        experienceService.fetchRecommendedExperiences()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API call failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { experiences in
                XCTAssertNotNil(experiences)
                XCTAssertGreaterThan(experiences.count, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
    }
    
    func testFetchMostRecentExperiences() {
        let expectation = self.expectation(description: "Fetch Most Recent Experiences")
        
        experienceService.fetchMostRecentExperiences()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API call failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { experiences in
                XCTAssertNotNil(experiences)
                XCTAssertGreaterThan(experiences.count, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
    }
    
    func testSearchExperiences() {
        let expectation = self.expectation(description: "Search Experiences")
        let searchTitle = "Cairo"
        
        experienceService.searchExperiences(with: searchTitle)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API call failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { experiences in
                XCTAssertNotNil(experiences)
                XCTAssertGreaterThan(experiences.count, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
    }
    
    func testFetchExperienceDetails() {
        let expectation = self.expectation(description: "Fetch Experience Details")
        let experienceId = "12345"
        
        experienceService.fetchExperienceDetails(for: experienceId)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API call failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { experience in
                XCTAssertNotNil(experience)
                XCTAssertEqual(experience.id, experienceId)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
    }
    
    func testLikeExperience() {
        let expectation = self.expectation(description: "Like Experience")
        let experienceId = "12345"
        
        experienceService.likeExperience(id: experienceId)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API call failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { likes in
                XCTAssertGreaterThan(likes, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
    }
}

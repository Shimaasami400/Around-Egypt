//
//  APIService.swift
//  Around Egypt
//
//  Created by Shimaa on 12/12/2024.
//

import Foundation
import Combine

protocol ExperienceServiceProtocol {
    func fetchRecommendedExperiences() -> AnyPublisher<[Experience], Error>
    func fetchMostRecentExperiences() -> AnyPublisher<[Experience], Error>
    func searchExperiences(with title: String) -> AnyPublisher<[Experience], Error>
    func fetchExperienceDetails(for id: String) -> AnyPublisher<Experience, Error>
    func likeExperience(id: String) -> AnyPublisher<Int, Error>
}

class ExperienceNetworkService: ExperienceServiceProtocol {
    
    func fetchRecommendedExperiences() -> AnyPublisher<[Experience], Error> {
        let urlString = "https://aroundegypt.34ml.com/api/v2/experiences?filter[recommended]=true"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMostRecentExperiences() -> AnyPublisher<[Experience], Error> {
        let urlString = "https://aroundegypt.34ml.com/api/v2/experiences"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func searchExperiences(with title: String) -> AnyPublisher<[Experience], Error> {
        let urlString = "https://aroundegypt.34ml.com/api/v2/experiences?filter[title]=\(title)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchExperienceDetails(for id: String) -> AnyPublisher<Experience, Error> {
        let urlString = "https://aroundegypt.34ml.com/api/v2/experiences/\(id)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Experience.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func likeExperience(id: String) -> AnyPublisher<Int, Error> {
        let urlString = "https://aroundegypt.34ml.com/api/v2/experiences/\(id)/like"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: LikeResponse.self, decoder: JSONDecoder())
            .map(\.likesNo)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct APIResponse: Decodable {
    let data: [Experience]
}

//
//  ExperienceModel.swift
//  Around Egypt
//
//  Created by Shimaa on 10/12/2024.
//

import Foundation

struct Tag: Identifiable, Decodable {
    let id: Int
    let name: String
}

struct City: Identifiable, Decodable {
    let id: Int
    let name: String
}

struct Experience: Identifiable, Decodable {
    let id: String
    let title: String
    let coverPhoto: String
    let description: String
    let viewsNo: Int
    var likesNo: Int
    let recommended: Int
    let tags: [Tag]
    let city: City?
    var liked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
        case tags
        case city
        case liked = "is_liked"
    }
    
    var isRecommended: Bool {
        return recommended == 1
    }
}

struct LikeResponse: Decodable {
    let likesNo: Int

    enum CodingKeys: String, CodingKey {
        case likesNo = "likes_no"
    }
}

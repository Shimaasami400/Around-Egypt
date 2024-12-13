//
//  userdefaults.swift
//  Around Egypt
//
//  Created by Shimaa on 13/12/2024.
//

import Foundation

extension UserDefaults {
    private static let likedExperiencesKey = "likedExperiences"
    
    var likedExperiences: Set<String> {
        get {
            return Set(array(forKey: UserDefaults.likedExperiencesKey) as? [String] ?? [])
        }
        set {
            set(Array(newValue), forKey: UserDefaults.likedExperiencesKey)
        }
    }
}

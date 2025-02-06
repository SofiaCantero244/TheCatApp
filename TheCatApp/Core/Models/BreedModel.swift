//
//  BreedModel.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import Foundation

struct BreedModel: Decodable {
    let id: String?
    let name: String?
    let temperament: String?
    let origin: String?
    let description: String?
    let referenceImageId: String?
    let adaptability: Int?
    let socialNeeds: Int?
    let healthIssues: Int?
    let dogFriendly: Int?
    let energyLevel: Int?
    let sheddingLevel: Int?
    let strangerFriendly: Int?
    let intelligence: Int?
    let childFriendly: Int?
    let grooming: Int?
    let affectionLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case origin
        case description
        case referenceImageId = "reference_image_id"
        case adaptability
        case socialNeeds = "social_needs"
        case healthIssues = "health_issues"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case sheddingLevel = "shedding_level"
        case strangerFriendly = "stranger_friendly"
        case intelligence
        case childFriendly = "child_friendly"
        case grooming
        case affectionLevel = "affection_level"
    }
}

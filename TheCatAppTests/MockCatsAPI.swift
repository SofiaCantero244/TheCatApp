//
//  MockCatsAPI.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 6/02/25.
//
import XCTest
import SwiftUI
@testable import TheCatApp

class MockCatsAPI: CatsAPIType {
    func fetchCatBreeds(limit: Int, page: Int) async throws -> (breeds: [BreedModel], error: CatError?) {
        return (breeds: MockBreedModel.mockBreeds, error: nil)
    }
    
    func fetchCatBreed(id: String) async throws -> (breed: BreedModel?, error: CatError?) {
        let breed = MockBreedModel.mockBreeds.first { $0.id == id }
        return (breed: breed, error: nil)
    }
    
    func fetchCatBreedImage(imageId: String) async throws -> (imageUrl: URL?, error: CatError?) {
        return (imageUrl: URL(string: "https://example.com/cat.jpg"), error: nil)
    }
}

class MockCatsErrorAPI: CatsAPIType {
    func fetchCatBreeds(limit: Int, page: Int) async throws -> (breeds: [BreedModel], error: CatError?) {
        return (breeds: [], error: CatError.network(code: 400, headers: [:]))
    }
    
    func fetchCatBreed(id: String) async throws -> (breed: BreedModel?, error: CatError?) {
        return (breed: nil, error: CatError.network(code: 400, headers: [:]))
    }
    
    func fetchCatBreedImage(imageId: String) async throws -> (imageUrl: URL?, error: CatError?) {
        return (imageUrl: nil, error: CatError.network(code: 400, headers: [:]))
    }
}

struct MockBreedModel {
    static let mockBreeds: [BreedModel] = [
        BreedModel(id: "abys", name: "Abyssinian", temperament: "Active, Energetic, Independent, Intelligent, Gentle", origin: "Egypt", description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.", referenceImageId: "xnsqonbjW", adaptability: 1, socialNeeds: 1, healthIssues: 2, dogFriendly: 3, energyLevel: 5, sheddingLevel: 3, strangerFriendly: 5, intelligence: 5, childFriendly: 2, grooming: 1, affectionLevel: 3),
        BreedModel(id: "asho", name: "American Shorthair", temperament: "Active, Curious, Easy Going, Playful, Calm", origin: "United States", description: "The American Shorthair is known for its longevity, robust health, good looks, sweet personality, and amiability with children, dogs, and other pets.", referenceImageId: "xnsqonbjW", adaptability: 4, socialNeeds: 5, healthIssues: 4, dogFriendly: 3, energyLevel: 5, sheddingLevel: 3, strangerFriendly: 4, intelligence: 4, childFriendly: 2, grooming: 4, affectionLevel: 5),
        BreedModel(id: "awir", name: "American Wirehair", temperament: "Affectionate, Curious, Gentle, Intelligent, Interactive, Lively, Loyal, Playful, Sensible, Social", origin: "United States", description: "The American Wirehair tends to be a calm and tolerant cat who takes life as it comes. His favorite hobby is bird-watching from a sunny windowsill, and his hunting ability will stand you in good stead if insects enter the house.", referenceImageId: "xnsqonbjW", adaptability: 1, socialNeeds: 1, healthIssues: 2, dogFriendly: 3, energyLevel: 5, sheddingLevel: 3, strangerFriendly: 5, intelligence: 5, childFriendly: 2, grooming: 1, affectionLevel: 3)
    ]
}

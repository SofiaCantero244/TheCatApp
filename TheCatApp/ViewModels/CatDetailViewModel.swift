//
//  CatDetailViewModel.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 5/02/25.
//

import Foundation

class CatDetailViewModel: ObservableObject {
    @Published var catDetail: BreedModel?
    @Published var catImageURL: URL?
    @Published var catList: [CatData] = []
    @Published var breedCharacteristics: [BreedCharacteristics] = []
    @Published var isLoading = false
    @Published var showErrorAlert = false
    
    let destinationViewModel: DestinationViewModel
    let catsAPI: CatsAPIType
    let catId: String
    
    init(catsAPI: CatsAPIType = CatsAPICore(), destinationViewModel: DestinationViewModel, catId: String) {
        self.catsAPI = catsAPI
        self.destinationViewModel = destinationViewModel
        self.catId = catId
    }
    
    @MainActor
    func fetchCatDetails() {
        Task {
            isLoading = true
            let result = try await catsAPI.fetchCatBreed(id: catId)
            let imageResult = try await catsAPI.fetchCatBreedImage(imageId: result.breed?.referenceImageId ?? "")
            isLoading = false
            
            guard result.error == nil else {
                showErrorAlert = true
                return
            }
            
            catDetail = result.breed
            catImageURL = imageResult.imageUrl
            breedCharacteristics = [
                BreedCharacteristics(title: "Adaptability", rating: catDetail?.adaptability),
                BreedCharacteristics(title: "Social Needs", rating: catDetail?.socialNeeds),
                BreedCharacteristics(title: "Health Issues", rating: catDetail?.healthIssues),
                BreedCharacteristics(title: "Dog Friendly", rating: catDetail?.dogFriendly),
                BreedCharacteristics(title: "Energy Level", rating: catDetail?.energyLevel),
                BreedCharacteristics(title: "Shedding Level", rating: catDetail?.sheddingLevel),
                BreedCharacteristics(title: "Stranger Friendly", rating: catDetail?.strangerFriendly),
                BreedCharacteristics(title: "Intelligence", rating: catDetail?.intelligence),
                BreedCharacteristics(title: "Child Friendly", rating: catDetail?.childFriendly),
                BreedCharacteristics(title: "Grooming", rating: catDetail?.grooming),
                BreedCharacteristics(title: "Affectionate", rating: catDetail?.affectionLevel)
            ]
        }
    }
}

struct BreedCharacteristics: Equatable, Hashable {
    let id: String
    let title: String
    let rating: Int
    
    init(title: String, rating: Int?) {
        self.id = "\(title)\(rating ?? 0)"
        self.title = title
        self.rating = rating ?? 0
    }
}

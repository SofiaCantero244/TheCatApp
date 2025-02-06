//
//  TheCatAppAPICore.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import Foundation

protocol CatsAPIType {
    func fetchCatBreeds(limit: Int, page: Int) async throws -> (breeds: [BreedModel], error: CatError?)
    func fetchCatBreed(id: String) async throws -> (breed: BreedModel?, error: CatError?)
    func fetchCatBreedImage(imageId: String) async throws -> (imageUrl: URL?, error: CatError?)
}

struct CatsAPICore: CatsAPIType {
    let apiInteractor = APIInteractor()
    
    func fetchCatBreeds(limit: Int, page: Int) async throws -> (breeds: [BreedModel], error: CatError?) {
        let request = APIRoute.fetchBreeds(limit: limit, page: page)
        let result = try await apiInteractor.manageRequest(with: request)
        switch result {
        case .success(let value):
            let breeds: [BreedModel]? = CoreDecoder.decode(data: value)
            return (breeds: breeds ?? [], error: nil)
        case .failure(let error):
            return (breeds: [], error: error)
        }
    }
    
    func fetchCatBreed(id: String) async throws -> (breed: BreedModel?, error: CatError?) {
        let request = APIRoute.fetchBreed(id: id)
        let result = try await apiInteractor.manageRequest(with: request)
        switch result {
        case .success(let value):
            let breed: BreedModel? = CoreDecoder.decode(data: value)
            print(value)
            return (breed: breed, error: nil)
        case .failure(let error):
            return (breed: nil, error: error)
        }
    }
    
    func fetchCatBreedImage(imageId: String) async throws -> (imageUrl: URL?, error: CatError?) {
        let request = APIRoute.fetchBreedImage(imageId: imageId)
        let result = try await apiInteractor.manageRequest(with: request)
        switch result {
        case .success(let value):
            let imageUrl: BreedImageModel? = CoreDecoder.decode(data: value)
            return (imageUrl: URL(string: imageUrl?.url ?? ""), error: nil)
        case .failure(let error):
            return (imageUrl: nil, error: error)
        }
    }
}

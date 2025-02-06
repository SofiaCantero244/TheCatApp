//
//  APIRoute.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import Foundation

enum APIRoute {
    case fetchBreeds(limit: Int, page: Int)
    case fetchBreed(id: String)
    case fetchBreedImage(imageId: String)
    
    var path: String {
        switch self {
        case .fetchBreeds:
            return "breeds"
        case .fetchBreed(let id):
            return "/breeds/\(id)"
        case .fetchBreedImage(let imageId):
            return "/images/\(imageId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchBreeds:
            return .get
        case .fetchBreed:
            return .get
        case .fetchBreedImage:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .fetchBreeds(let limit, let page):
            return [
                "limit": limit,
                "page": page
            ]
        default:
            return [:]
        }
    }
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

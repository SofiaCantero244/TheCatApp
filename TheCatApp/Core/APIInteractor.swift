//
//  APIInteractor.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import Foundation

struct APIInteractor {
    func manageRequest(with route: APIRoute) async throws -> Result<Data, CatError> {
        guard let urlRequest = getURLRequest(route: route) else {
            return .failure(CatError.invalidRequest)
        }
        
        let session = URLSession(configuration: .ephemeral)
        let (data, response) = try await session.data(for: urlRequest)

        let responseResult = response as? HTTPURLResponse
        let code = responseResult?.statusCode ?? 0
        if 200 ... 299 ~= code {
            return .success(data)
        } else {
            return .failure(CatError.network(
                code: code, headers: responseResult?.allHeaderFields as? NSDictionary as? [String : Any] ?? [:]
            ))
        }
    }
    
    func getURLRequest(route: APIRoute) -> URLRequest? {
        guard let url = URL(string: AppConfiguration.baseURL)?.appendingPathComponent(route.path) else { return nil }
        
        var urlRequest: URLRequest?
        switch route.method {
        case .get, .delete:
            urlRequest = url.getRequest(parameters: route.parameters)
        default:
            urlRequest = url.getBodyRequest(parameters: route.parameters)
        }
        
        urlRequest?.httpMethod = route.method.rawValue
        urlRequest?.timeoutInterval = 20
        
        return urlRequest
    }
}

extension URL {
    func getRequest(parameters: [String: Any]) -> URLRequest? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }

        let queryItems: [URLQueryItem] = parameters.keys.compactMap({ URLQueryItem(name: $0, value: "\(parameters[$0] ?? "")") })
        components.queryItems = queryItems

        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
    
    func getBodyRequest(parameters: [String: Any]) -> URLRequest? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let url = components.url
        else { return nil }
        
        var request = URLRequest(url: url)
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
}


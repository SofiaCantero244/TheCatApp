//
//  NetworkError.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import Foundation

enum CatError: Error {
    case invalidRequest
    case parsing
    case network(code: Int, headers: [String: Any])
}

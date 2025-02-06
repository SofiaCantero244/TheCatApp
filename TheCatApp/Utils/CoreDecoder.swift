//
//  CoreDecoder.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import Foundation

struct CoreDecoder {
    static func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch   {
            print(error.localizedDescription)
            return nil
        }
    }
}

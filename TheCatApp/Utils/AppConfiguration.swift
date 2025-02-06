//
//  AppConfiguration.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import Foundation

struct AppConfiguration {
    static var baseURL: String {
        let url = plistConfiguration["url"] ?? ""
        let version = plistConfiguration["api_version"] ?? ""
        return "\(url)/\(version)"
    }
    
    static var plistConfiguration: [String: String] {
        guard
            let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String]
        else { return [:] }
        
        return plist
    }
}

//
//  AppConfig.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation

struct AppConfig {
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found.")
        }
        return dict
    }()
    
    static let apiKey: String = {
        guard let apiKeyString = AppConfig.infoDictionary["API_KEY"] as? String else {
            fatalError("API_KEY not set in Info.plist for this configuration.")
        }
        return apiKeyString
    }()
}

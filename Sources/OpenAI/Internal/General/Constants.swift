//
//  Constants.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

enum Constants {
    enum API {
        static let baseURL = "api.openai.com"
        static let scheme = "https"
        static let versionPath = "/v1"
        
        enum Headers {
            static let contentType = (key: "Content-Type", value: "application/json")
            
            static func token(_ token: String) -> (key: String, value: String) {
                (key: "Authorization", value: "Bearer \(token)")
            }
            
            static func organization(_ org: String) -> (key: String, value: String) {
                (key: "OpenAI-Organization", value: org)
            }
        }
    }
}

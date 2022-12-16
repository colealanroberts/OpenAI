//
//  OpenAI+Credentials.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+Credentials` -

public extension OpenAI {
    struct Credentials: ExpressibleByStringLiteral {
        let token: String
        let organization: String?
        
        public init(stringLiteral value: StringLiteralType) {
            self.token = value
            self.organization = nil
        }
        
        var isEmpty: Bool {
            return token.isEmpty && organization == nil
        }
    }
}

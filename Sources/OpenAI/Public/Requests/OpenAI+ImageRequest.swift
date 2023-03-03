//
//  OpenAI+ImageRequest.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+ImageRequest` -

public extension OpenAI {
    struct ImageRequest {
        /// A text description of the desired image(s). The maximum length is 1000 characters.
        let prompt: String
        
        /// The number of images to generate. Must be between 1 and 10.
        let numberOfImages: Int?
        
        /// The size of the generated images. (small: 256x256, normal: 512x512, large: 1024x1024x)
        let size: Size?
        
        /// The format in which the generated images are returned.
        let response: Response?
        
        /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. Learn more.
        let user: String?
        
        public init(
            prompt: String,
            numberOfImages: Int? = nil,
            size: Size? = nil,
            response: Response? = nil,
            user: String? = nil
        ) {
            self.prompt = prompt
            self.numberOfImages = numberOfImages
            self.size = size
            self.response = response
            self.user = user
        }
    }
}

// MARK: - `OpenAI.ImageRequest+ExpressibleByStringLiteral` -

extension OpenAI.ImageRequest: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(prompt: value)
    }
}

// MARK: - `OpenAI.ImageRequest+Size

public extension OpenAI.ImageRequest {
    enum Size {
        case small
        case normal
        case large
        
        var stringRepresentation: String {
            switch self {
            case .small: return "256x256"
            case .normal: return "512x512"
            case .large: return "1024x1024"
            }
        }
    }
    
    enum Response: String {
        case url
        case b64JSON
    }
}

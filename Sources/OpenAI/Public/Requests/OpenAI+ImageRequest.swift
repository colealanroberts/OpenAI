//
//  OpenAI+ImageRequest.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+ImageRequest` -

public extension OpenAI {
    struct ImageRequest: ExpressibleByStringLiteral {
        /// A text description of the desired image(s). The maximum length is 1000 characters.
        let prompt: String
        
        /// The number of images to generate. Must be between 1 and 10.
        let numberOfImages: Int
        
        // The size of the generated images. (small: 256x256, normal: 512x512, large: 1024x1024x)
        let size: Size
        
        /// The format in which the generated images are returned.
        let response: Response
        
        public init(
            prompt: String,
            numberOfImages: Int,
            size: Size,
            response: Response
        ) {
            self.prompt = prompt
            self.numberOfImages = numberOfImages
            self.size = size
            self.response = response
        }
        
        public init(stringLiteral value: StringLiteralType) {
            self.prompt = value
            self.numberOfImages = 1
            self.size = .normal
            self.response = .url
        }
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

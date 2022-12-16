//
//  ImageModel.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Foundation

// MARK: - `ImageModel` -

public struct ImageModel {
    public let url: URL
}

// MARK: - `ImageModel+Decodable` -

extension ImageModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case url
    }
    
    public init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let backing = try container.decode(String.self, forKey: .url)
            self.url = URL(string: backing)!
        } catch {
            fatalError()
        }
    }
}

// MARK: - `Typealias` -

public typealias Image = ImageModel

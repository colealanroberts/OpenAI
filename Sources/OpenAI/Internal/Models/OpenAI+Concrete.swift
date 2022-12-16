//
//  OpenAI+Concrete.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+Concrete` -

extension OpenAI {
    struct Concrete<T: Requestable, U>: APIRequest {
        typealias Response = U
        typealias Request = T
        
        // MARK: - `Public Properties` -

        var body: Request? { request }
        var method: APIRequestMethod { T.method }
        var path: String { T.path }
        
        // MARK: - `Init` -
        
        let request: Request
    }
}

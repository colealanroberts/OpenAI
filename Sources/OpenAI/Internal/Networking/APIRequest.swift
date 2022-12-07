//
//  APIRequest.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Foundation

// MARK: - `APIRequestMethod` -

enum APIRequestMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - `APIRequestError` -

enum APIRequestError: Error {
    case statusCode(Int)
}

// MARK: - `APIRequest` -

protocol APIRequest {
    associatedtype Response
    
    typealias Header = (key: String, value: String)
    
    var headers: [Header]? { get }
    var method: APIRequestMethod { get }
    var path: String { get }
    var host: String { get }
    var body: [String: Any] { get }
    var request: URLRequest { get }
}

extension APIRequest {
    var body: [String: Any] { [:] }
    var scheme: String { "https" }
    var host: String { "api.openai.com" }
}

extension APIRequest {
    var request: URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/v1" + path
        
        guard let url = components.url else {
            fatalError("The supplied url \(String(describing: components.url)) was malformed!")
        }
        
        return URLRequest(url: url)
    }
    
    fileprivate func materialize() -> URLRequest {
        var req = request
        req.httpMethod = method.rawValue
        
        do {
            req.httpBody = try JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
        } catch {
            assertionFailure(String(describing: error))
        }
        
        if let headers {
            headers.forEach {
                req.addValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        return req
    }
}

extension APIRequest where Response: Decodable {
    func send(
        _ decoder: JSONDecoder = .init()
    ) async throws -> Response {
        do {
            let (data, response) = try await URLSession.shared.data(for: materialize())
            guard let response = response as? HTTPURLResponse else { fatalError() }
            guard (200...299).contains(response.statusCode) else {
                throw APIRequestError.statusCode(response.statusCode)
            }
            let decoded = try decoder.decode(Request<Response>.self, from: data)
            return decoded.data
        } catch {
            throw error
        }
    }
}

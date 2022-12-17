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
    associatedtype Method = APIRequestMethod
    associatedtype Response
    associatedtype Request: Encodable
    
    typealias Header = (key: String, value: String)
    
    var headers: [Header]? { get }
    var method: APIRequestMethod { get }
    var path: String { get }
    var host: String { get }
    var body: Request? { get }
    var request: URLRequest { get }
}

extension APIRequest {
    var body: Encodable? { nil }
    var scheme: String { Constants.API.scheme  }
    var host: String { Constants.API.baseURL }
    
    var headers: [Header]? {
        guard let credentials = OpenAI.shared.credentials else { return nil }
        var headers: [Header] = [
            Constants.API.Headers.contentType,
            Constants.API.Headers.token(credentials.token)
        ]
        
        if let organization = credentials.organization {
            headers.append(Constants.API.Headers.organization(organization))
        }
        
        return headers
    }
}

extension APIRequest {
    var request: URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = Constants.API.versionPath + path
        
        guard let url = components.url else {
            fatalError("The supplied url \(String(describing: components.url)) was malformed!")
        }
        
        return URLRequest(url: url)
    }
    
    fileprivate func materialize(_ encoder: JSONEncoder) -> URLRequest {
        var req = request
        req.httpMethod = method.rawValue
        
        do {
            req.httpBody = try encoder.encode(body)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        headers?.forEach {
            req.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return req
    }
}

extension APIRequest where Response: Decodable {
    func send(
        _ decoder: JSONDecoder,
        _ encoder: JSONEncoder
    ) async throws -> Response {
        do {
            let (data, response) = try await URLSession.shared.data(for: materialize(encoder))
            guard let response = response as? HTTPURLResponse else { fatalError() }
            guard (200...299).contains(response.statusCode) else {
                throw APIRequestError.statusCode(response.statusCode)
            }
            let decoded = try decoder.decode(Response.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
}

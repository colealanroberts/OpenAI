import Combine
import Foundation

// MARK: - `OpenAISDK` -

public protocol OpenAISDK {
    func connect(with credentials: OpenAI.Credentials) -> Self
    func completions(for request: OpenAI.CompletionRequest) async throws -> Completion
    func images(for request: OpenAI.ImageRequest) async throws -> [Image]
}

// MARK: - `OpenAI` -

/// ``OpenAI``
///
public final class OpenAI: OpenAISDK {
    
    // MARK: - `Static Properties` -
    
    public static let shared: OpenAI = .init()
    
    // MARK: - `Public Properties` -
    
    public private(set) var credentials: Credentials?
    
    // MARK: - `Private Properties` -
    
    private let imageService: ImageServicing
    private let completionService: CompletionServicing
    
    // MARK: - `Init` -
    
    private init() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        self.imageService = ImageService(decoder: decoder, encoder: encoder)
        self.completionService = CompletionService(decoder: decoder, encoder: encoder)
    }
    
    // MARK: - `Public Methods` -
    
    @discardableResult
    public func connect(with credentials: Credentials) -> Self {
        self.credentials = credentials
        return self
    }
    
    public func images(for request: ImageRequest) async throws -> [Image] {
        preflightCheck()
        return try await imageService.images(for: request)
    }
    
    public func completions(for request: CompletionRequest) async throws -> Completion {
        preflightCheck()
        return try await completionService.completions(for: request)
    }
    
    // MARK: - `Private Methods` -
    
    private func preflightCheck() {
        guard let credentials = credentials, !credentials.isEmpty else {
            preconditionFailure("You must supply `Credentials` before performing a request!")
        }
    }
}

import Combine
import Foundation

// MARK: - `OpenAISDK` -

public protocol OpenAISDK {
    func images(for request: OpenAI.ImageRequest) async throws -> [Image]
}

// MARK: - `OpenAI` -

/// ``OpenAI``
///
public final class OpenAI: OpenAISDK {
    
    // MARK: - `Public Properties` -
    
    public static let shared: OpenAI = .init()
    
    // MARK: - `Private Properties` -
    
    var credentials: Credentials?
    
    private let imageService: ImageServicing
    
    // MARK: - `Init` -
    
    private init() {
        self.imageService = ImageService()
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
    
    // MARK: - `Private Methods` -
    
    private func preflightCheck() {
        guard let credentials = credentials, !credentials.isEmpty else {
            fatalError("You must supply `Credentials` before performing a request!")
        }
    }
}

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
        
        func toPixel() -> String {
            switch self {
            case .small: return "256x256"
            case .normal: return "512x512"
            case .large: return "1024x1024"
            }
        }
    }
    
    enum Response {
        case url
        case b64JSON
    }
}

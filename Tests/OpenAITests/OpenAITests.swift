import XCTest
@testable import OpenAI

final class OpenAITests: XCTestCase {
    
    // MARK: - `Private Properties` -
    
    private var openai: MockOpenAI!
    
    // MARK: - `Lifecycle` -
    
    override func setUp() async throws {
        self.openai = MockOpenAI()
    }
    
    func test_makeImageRequest() async {
        do {
            let images = try await openai.images(for: "A mock request")
            assert(!images.isEmpty)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

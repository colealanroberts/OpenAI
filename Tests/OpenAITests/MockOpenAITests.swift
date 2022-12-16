import XCTest
@testable import OpenAI

final class MockOpenAITests: XCTestCase {
    
    // MARK: - `Private Properties` -
    
    private var openai: OpenAISDK!
    
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
    
    func test_makeCompletionRequest() async {
        do {
            let completions = try await openai.completions(for: .init(model: .gpt3(.davinci), prompt: "Say this is a test"))
            dump(completions)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

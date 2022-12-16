//
//  File.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+CompletionRequest` -

public extension OpenAI {
    struct CompletionRequest {
        /// ID of the model to use. See ``Model``
        let model: Model
        
        /// The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.
        let prompt: [String]
        
        /// The maximum number of tokens to generate in the completion.
        /// The token count of your prompt plus max_tokens cannot exceed the model's context length.
        /// Most models have a context length of 2048 tokens (except for the newest models, which support 4096).
        let maxTokens: Int
        
        public init(
            model: Model,
            prompt: String...,
            maxTokens: Int = 16
        ) {
            self.model = model
            self.prompt = prompt
            self.maxTokens = maxTokens
        }
    }
}

// MARK: - `OpenAI+CompletionRequest+Model` -

public extension OpenAI {
    /// See: https://beta.openai.com/docs/models/overviewaa
    enum Model {
        
        /// See ``GPT3``
        case gpt3(GPT3)
        
        /// See ``Codex``
        case codex(Codex)
        
        public enum GPT3 {
            /// Davinci is the most capable model family, able to perform any task the other models can perform, often with less instruction.
            /// It excels at applications requiring a deep understanding of content, such as summarization for a specific audience and creative content generation.
            /// Davinci is also very good at understanding the intent of text and solving logic problems, including those involving cause and effect.
            /// However, these increased capabilities come at a cost, as Davinci requires more compute resources and is therefore more expensive per API call and not as fast as the other models.
            /// - Note: Good at: Complex intent, cause and effect, summarization for audience
            case davinci
            
            /// Curie is a powerful and fast language model. It excels at tasks like sentiment classification and summarization.
            /// It is also very capable at answering questions and serving as a general chatbot.
            /// While Davinci may be stronger at analyzing complicated text, Curie is more than capable for many nuanced tasks.
            /// - Note: Good at: Language translation, complex classification, text sentiment, summarization
            case curie
            
            /// Babbage is capable of performing straightforward tasks like simple classification.
            /// It is also quite proficient at Semantic Search, ranking how well documents match up with search queries.
            /// - Note: Good at: Moderate classification, semantic search classification
            case babbage
            
            /// Ada is generally the fastest model and is capable of tasks such as parsing text, address correction, and certain classification tasks that do not require a lot of nuance.
            /// Its performance can often be improved by providing more context.
            /// - Note: Good at: Parsing text, simple classification, address correction, keywords
            case ada
        }
        
        public enum Codex {
            /// Most capable Codex model. Particularly good at translating natural language to code.
            /// In addition to completing code, also supports inserting completions within code.
            case davinci
            
            /// Almost as capable as Davinci Codex, but slightly faster.
            /// This speed advantage may make it preferable for real-time applications.
            case cushman
        }
        
        // MARK: - `Utility` -
        
        var stringRepresentation: String {
            switch self {
            case .codex(let type):
                switch `type` {
                case .cushman:
                    return "code-cushman-001"
                case .davinci:
                    return "code-davinci-002"
                }
                
            case .gpt3(let type):
                switch `type` {
                case .ada:
                    return "text-ada-001"
                case .babbage:
                    return "text-babbage-001"
                case .curie:
                    return "text-curie-001"
                case .davinci:
                    return "text-davinci-003"
                }
            }
        }
    }
}

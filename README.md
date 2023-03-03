# OpenAI

A Swift package for interacting with OpenAI
  - [x] Utilizing ChatGPT using the [ChatGPT API](https://platform.openai.com/docs/api-reference/chat/create)
  - [x] Request N completions using the [Completions API](https://beta.openai.com/docs/api-reference/completions/create)
  - [x] Requesting N images using the [Image Generation API](https://beta.openai.com/docs/guides/images)
    - [ ] Creating an image mask
  
## Quick Start

### Authentication

Import `OpenAI` and then add your API key from [OpenAI](https://openai.com/api/). The API can be initialized directly or accessed using the static `shared` property.

```swift
import OpenAI

OpenAI.shared.connect(with: "your-key")
// or
let openai = OpenAI(credentials: "your-key")
```
### Chats

An example using several of the available roles (`assistant`, `system` and `user`) with content.

```swift
let chats = try await openai.chats(
    for: .init(
        model: .gpt3(.turbo),
        messages: [
            .system("You are a helpful assistant."),
            .user("Who won the world series in 2020?"),
            .assistant("The Los Angeles Dodgers won the World Series in 2020."),
            .user("Where was it played?")
        ]
    )
)
print(chats)
```
> This request supplies nil values by default for many of the available parameters, which can be supplied for added flexibility.

### Completions

A simple request where the prompt is echoed back.

```swift
let completions = try await openai.completions(
    for: .init(
        model: .gpt3(.davinci),
        prompt: "Say this is a test"
    )
)
print(completions)
```
> This request supplies nil values by default for many of the available parameters, which can be supplied for added flexibility.

### Images

A simple request for creating an image of a cat.
```swift
let images = try await openai.images(for: "A white siamese cat")
print(images) // images[0].url
```
> This request supplies nil values by default for many of the available parameters, which can be supplied for added flexibility.

## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Contributing

Please feel free to open a PR with desired changes and a brief description.

## Disclaimer

This package is not endorsed by, directly affiliated with, maintained, authorized, or sponsored by OpenAI.

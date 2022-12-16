# OpenAI

A Swift package for interacting with OpenAI
  - [x] Requesting N images using the [Image Generation API](https://beta.openai.com/docs/guides/images)
  - [ ] Creating an image mask
  
## Quick Start

**Connect**

To begin using OpenAI, add your API key from [OpenAI](https://openai.com/api/).

```swift
OpenAI.shared.connect(with: "your-key")
```

**Request Images**

Request can be performed using a simple `String` or by passing in a `OpenAI.ImageRequest` struct.
```swift
let images = try await OpenAI.shared.images(for: "An astronaut riding a horse in photorealistic style")
// or
let images = try await OpenAI.shared.images(for: OpenAI.ImageRequest)

print(images) // images[0].url
```

A more verbose request may provide the following—
```swift
struct ImageRequest: ExpressibleByStringLiteral {
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    let numberOfImages: Int
    // The size of the generated images. (`small`: 256x256, `normal`: 512x512, `large`: 1024x1024x)
    let size: Size
    /// The format in which the generated images are returned. (`json` or `b64JSON`)
    let response: Response 
}
```

## Authentication

> **Warning**
>
> Remember that your API key is a secret! Do not share it with others or expose it in any client-side code (browsers, apps). Production requests must be > routed through your own backend server where your API key can be securely loaded from an environment variable or key management service.  - [Source](https://beta.openai.com/docs/api-reference/authentication)

## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Contributing

Please feel free to open a PR with desired changes and a brief description.

## Disclaimer

This package is not endorsed by, directly affiliated with, maintained, authorized, or sponsored by OpenAI.

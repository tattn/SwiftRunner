SwiftRunner
===

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20Linux-333333.svg)
[![License](https://img.shields.io/github/license/tattn/SwiftRunner.svg)]()
[![Swift Version](https://img.shields.io/badge/Swift-3.0+-F16D39.svg)](https://developer.apple.com/swift)


SwiftRunner can execute text written in Swift.

# How to use

## Execute string as Swift

```swift
import SwiftRunner

let text   = "print(\"hello!\")"
let result = SwiftRunner.shared.launch(string: text) // => hello!

switch result {
case .success(let stream):
    stream.output // => "hello!\n"

case .failure(let error): break
}
```

# Requirements

- Xcode 8.0+
- Swift 3.0+

# Installation

## Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "MyProject",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/tattn/SwiftRunner.git", majorVersion: 1)
    ]
)
```

# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

# License

SwiftRunner is released under the MIT license. See LICENSE for details.

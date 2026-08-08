# Contributing

## Development requirements

- Xcode with Swift 5.3 or newer.
- Supported deployment targets: iOS 13.0+ and macOS 10.15+.
- `swift-format` for local formatting, using the repository `.swift-format` configuration.

## Before opening a pull request

Run the same checks as CI:

```sh
swift test --scratch-path .build/macos
swift build --scratch-path .build/ios --sdk "$(xcrun --sdk iphoneos --show-sdk-path)" --triple arm64-apple-ios13.0
swiftc -typecheck -swift-version 6 -strict-concurrency=complete -target arm64-apple-macosx14.0 -module-name Neumorphic Sources/Neumorphic/*.swift
swift package diagnose-api-breaking-changes v2.0.7 --products Neumorphic
git diff --check
```

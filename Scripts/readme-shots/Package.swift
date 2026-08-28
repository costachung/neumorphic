// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "readme-shots",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "readme-shots", targets: ["ReadmeShots"])
    ],
    dependencies: [.package(path: "../..")],
    targets: [
        .executableTarget(
            name: "ReadmeShots",
            dependencies: [.product(name: "Neumorphic", package: "neumorphic")])
    ])

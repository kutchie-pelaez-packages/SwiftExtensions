// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "SwiftExtensions", targets: ["SwiftExtensions"])
    ],
    targets: [
        .target(name: "SwiftExtensions", path: "Sources"),
        .testTarget(name: "SwiftExtensionsTests", dependencies: [
            .target(name: "SwiftExtensions")
        ], path: "Tests")
    ]
)

// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayByBank",
    defaultLocalization: "en",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PayByBank",
            targets: ["PayByBank"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PayByBank",
            dependencies: [],
            resources: [.process("Resources")])
    ]
)

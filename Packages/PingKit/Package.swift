// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PingKit",

    products: [
        .library(name: "PingKit", targets: ["PingKit"])
    ],

    targets: [
        .target(name: "PingKit"),
        .testTarget(name: "PingKitTests", dependencies: ["PingKit"])
    ]
)

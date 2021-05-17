// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "ListPlaceholder",
    products: [
        .library(name: "ListPlaceholder", targets: ["ListPlaceholder"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "ListPlaceholder", dependencies: [], path: "Sources")
    ]
)

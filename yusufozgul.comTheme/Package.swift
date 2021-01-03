// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "yusufozgul.comTheme",
    products: [
        .library(
            name: "yusufozgul.comTheme",
            targets: ["yusufozgul.comTheme"]),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
        .package(url: "https://github.com/alexito4/ReadingTimePublishPlugin", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "yusufozgul.comTheme",
            dependencies: ["Publish",
                           "ReadingTimePublishPlugin"]),
        .testTarget(
            name: "yusufozgul.comThemeTests",
            dependencies: ["yusufozgul.comTheme"]),
    ]
)

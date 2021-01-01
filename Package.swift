// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "YusufozgulCom",
    products: [
        .executable(
            name: "YusufozgulCom",
            targets: ["YusufozgulCom"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "YusufozgulCom",
            dependencies: ["Publish"]
        )
    ]
)

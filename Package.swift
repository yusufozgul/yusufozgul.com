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
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
        .package(url: "https://github.com/alexito4/ReadingTimePublishPlugin", from: "0.1.0"),
        .package(url: "https://github.com/insidegui/TwitterPublishPlugin.git", from: "0.1.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0"),
        .package(url: "https://github.com/finestructure/ImageAttributesPublishPlugin", from: "0.1.1"),
        .package(name: "LinkAttributesPublishPlugin", url: "https://github.com/cweinberger/LinkAttributesPublishPlugin", from: "1.0.0"),
        .package(url: "https://github.com/thomaslupo/GistPublishPlugin", from: "0.1.0"),
        .package(url: "https://github.com/wacumov/VerifyResourcesExistPublishPlugin", from: "0.1.0"),
        .package(name: "yusufozgul.comTheme", path: "./yusufozgul.comTheme/")
    ],
    targets: [
        .target(
            name: "YusufozgulCom",
            dependencies: ["Publish", "ReadingTimePublishPlugin",
                           "TwitterPublishPlugin",
                           "SplashPublishPlugin",
                           "ImageAttributesPublishPlugin",
                           "LinkAttributesPublishPlugin",
                           "GistPublishPlugin",
                           "VerifyResourcesExistPublishPlugin",
                           "yusufozgul.comTheme"]
        )
    ]
)

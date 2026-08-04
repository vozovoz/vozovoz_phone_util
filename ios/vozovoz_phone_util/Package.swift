// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "vozovoz_phone_util",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "vozovoz-phone-util", targets: ["vozovoz_phone_util"])
    ],
    dependencies: [
        .package(url: "https://github.com/PhoneNumberKit/PhoneNumberKit", from: "5.0.6")
    ],
    targets: [
        .target(
            name: "vozovoz_phone_util",
            dependencies: [
                .product(name: "PhoneNumberKit", package: "PhoneNumberKit")
            ]
        )
    ]
)

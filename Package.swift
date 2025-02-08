// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "KisiselFinansUygulamasi",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "KisiselFinansUygulamasi",
            targets: ["KisiselFinansUygulamasi"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0"),
    ],
    targets: [
        .target(
            name: "KisiselFinansUygulamasi",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCore", package: "firebase-ios-sdk")
            ]),
        .testTarget(
            name: "KisiselFinansUygulamasiTests",
            dependencies: ["KisiselFinansUygulamasi"]),
    ]
) 
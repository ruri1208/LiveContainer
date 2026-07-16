// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LiveContainerKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LiveContainerKit",
            targets: ["LiveContainerUI", "LCBootstrap"]
        )
    ],
    dependencies: [
        
        .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", from: "3.1.5000")
    ],
    targets: [
        
        .target(
            name: "litehook",
            path: "litehook", 
            exclude: [
                "CMakeLists.txt", 
                "LICENSE", 
                "README.md"
            ],
            publicHeadersPath: "." 
        ),

        
        .target(
            name: "LCBootstrap",
            dependencies: [
                "litehook",
                
                .product(name: "OpenSSL", package: "OpenSSL")
            ],
            path: "LiveContainer",
            exclude: [
                "Info.plist",
                "LiveContainerSwiftUI" 
            ],
            sources: [
                "LCBootstrap" 
            ],
            publicHeadersPath: "LCBootstrap/include",
            cSettings: [
                .headerSearchPath("LCBootstrap/include")
            ],
            cxxSettings: [
                .headerSearchPath("LCBootstrap/include")
            ]
        ),


        .target(
            name: "LiveContainerUI",
            dependencies: ["LCBootstrap"],
            path: "LiveContainer/LiveContainerSwiftUI",
            sources: [
                "." 
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
}

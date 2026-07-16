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
        
        
        .binaryTarget(
            name: "OpenSSL",
            path: "OpenSSL/OpenSSL.xcframework" 
        ),

        
        .target(
            name: "LCBootstrap",
            dependencies: [
                "litehook",
                "OpenSSL"   
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

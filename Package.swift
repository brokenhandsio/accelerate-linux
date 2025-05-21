// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "accelerate-linux",
    products: [
        .library(
            name: "AccelerateLinux",
            targets: ["AccelerateLinux"]
        )
    ],
    targets: [
        .target(
            name: "AccelerateLinux",
            dependencies: ["CBLAS", "CLAPACK"],
            swiftSettings: [
                .enableExperimentalFeature("Extern")
            ]
        ),
        .systemLibrary(
            name: "CBLAS",
            pkgConfig: "openblas",
            providers: [
                .aptItem(["libopenblas-dev"])
            ]
        ),
        .systemLibrary(
            name: "CLAPACK",
            pkgConfig: "lapacke",
            providers: [
                .aptItem(["liblapacke-dev"])
            ]
        ),
        .testTarget(
            name: "AccelerateLinuxTests",
            dependencies: ["AccelerateLinux"]
        ),
    ]
)

// swift-tools-version: 6.0
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
            dependencies: ["CBLAS", "CLAPACK"]
        ),
        .systemLibrary(
            name: "CBLAS",
            pkgConfig: "blas",
            providers: [
                .aptItem(["libblas-dev"]),
                .brewItem(["openblas"]),
            ]
        ),
        .systemLibrary(
            name: "CLAPACK",
            pkgConfig: "lapack",
            providers: [
                .aptItem(["liblapack-dev"]),
                .brewItem(["openblas"]),
            ]
        ),
        .testTarget(
            name: "AccelerateLinuxTests",
            dependencies: ["AccelerateLinux"]
        ),
    ]
)

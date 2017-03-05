import PackageDescription

let package = Package(
    name: "SwiftRunner",
    dependencies: [
        .Package(url: "https://github.com/antitypical/Result.git", majorVersion: 3)
    ]
)

import PackageDescription

let package = Package(
    name: "MeowVaporExample",
    dependencies: [
        .Package(url: "https://github.com/OpenKitten/MeowVapor.git", majorVersion: 0, minor: 1)
    ]
)

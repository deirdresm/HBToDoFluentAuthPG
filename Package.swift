// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//
let fluentRevision = "4e80bf86d44223eed7e1366d5d8ab23205c0cd14" // include fix mentioned in https://github.com/hummingbird-project/hummingbird-examples/pull/112

let package = Package(
    name: "ToDosFluentAuth",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.1"),
		.package(url: "https://github.com/hummingbird-project/hummingbird-auth.git", from: "2.0.0-rc.4"),
		.package(url: "https://github.com/hummingbird-project/hummingbird-fluent.git", revision: fluentRevision),
		.package(url: "https://github.com/hummingbird-project/swift-mustache.git", from: "2.0.0-rc.1"),
		.package(url: "https://github.com/vapor/fluent-kit.git", from: "1.49.0"),
		.package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.9.2"),
		.package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.7.4"),
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
    ],
    targets: [
		.executableTarget(
			name: "App",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
				.product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
				.product(name: "FluentKit", package: "fluent-kit"),
				.product(name: "Hummingbird", package: "hummingbird"),
				.product(name: "Bcrypt", package: "hummingbird-auth"),
				.product(name: "HummingbirdAuth", package: "hummingbird-auth"),
				.product(name: "HummingbirdBasicAuth", package: "hummingbird-auth"),
				.product(name: "HummingbirdFluent", package: "hummingbird-fluent"),
				.product(name: "Mustache", package: "swift-mustache"),
			],
			resources: [.process("Resources")],
			swiftSettings: [
				// Enable better optimizations when building in Release configuration. Despite the use of
				// the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
				// builds. See <https://github.com/swift-server/guides#building-for-production> for details.
				.unsafeFlags(["-cross-module-optimization"], .when(configuration: .release)),
			]
		),
        .testTarget(name: "AppTests",
            dependencies: [
                .byName(name: "App"),
                .product(name: "HummingbirdTesting", package: "hummingbird"),
				.product(name: "HummingbirdAuthTesting", package: "hummingbird-auth"),
            ],
            path: "Tests/AppTests"
        )
    ]
)

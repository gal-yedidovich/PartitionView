// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "Partition"
let package = Package(
	name: name,
	platforms: [.iOS(.v13), .macOS(.v10_15)],
	products: [.library(name: name, targets: [name])],
	targets: [.target(name: name)]
)

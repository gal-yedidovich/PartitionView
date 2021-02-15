// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let partitionBar = "PartitionBar"

let package = Package(
	name: partitionBar,
	platforms: [.iOS(.v13), .macOS(.v10_15)],
	products: [.library(name: partitionBar, targets: [partitionBar])],
	targets: [.target(name: partitionBar)]
)

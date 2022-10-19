# PartitionView - Beautiful view to represent numeric values

This library provides a single View, `Partition`, that can represent a single or multiple numeric values together as a bar or pie chart for graphical purposes.

## Installation
PartitionView is a *Swift Package*. 

Use the swift package manager to install PartitionView on your project. [Apple Developer Guide](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Basic Usage 

#### Navigation
```swift
let values: [Partition.Value] = [
	.init(value: 0.4, color: .green),
	.init(value: 0.6, color: .orange),
]

Partition(values)
	.frame(width: 200, height: 30)
```
The following code will present an horizonal bar with 2 values, one has 40% with color green, and the other has 60% with color orange.

![Horizontal Bar - parition view](https://user-images.githubusercontent.com/29046630/196681036-0d6e9002-625a-43c0-ac80-86dd332312ca.png)

### Basic Modifiers
```swift
let values: [Partition.Value] = [
	.init(value: 0.1, color: .blue),
	.init(value: 0.6, color: .white),
	.init(value: 0.3, color: .gray),
]

Partition(values)
	.border(color: .clear) //sets the color of the border
	.frame(width: 200, height: 30)
```
![Custom Border Color](https://user-images.githubusercontent.com/29046630/196680532-abcfd063-59d5-435c-bcb6-c46974c3ee2f.png)

### Styles
```swift
let values: [Partition.Value] = [
	.init(value: 0.25, color: .yellow),
	.init(value: 0.5, color: .green),
	.init(value: 0.25, color: .blue),
]

Partition(values)
	.partitionStyle(PiePartitionStyle()) //presents the data as a "Pie chart"
	.frame(width: 100, height: 100)
```
![Pie chart style](https://user-images.githubusercontent.com/29046630/196680536-e22bf98d-f1bd-42a9-9965-0911bc1eb6a5.png)

Other available styles:  `DefaultPartitionStyle`, `VerticalBarPartitionStyle`, `OvalPartitionStyle`


> Other examples are available in the source code's previews [link](https://github.com/gal-yedidovich/PartitionView/blob/main/Sources/Partition/Partition.swift)

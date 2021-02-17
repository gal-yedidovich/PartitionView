# PartitionView - Beautiful view to represent numeric values

This library provides a single View, `Partition`, that can represent a single or multiple numeric values together for graphical purposes. 

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
The following code will present an horizonal bar with 2 values, one has 40% with color green, and the other has 60% with color orange 


### Basic Modifiers
```swift
let values: [Partition.Value] = [
	.init(value: 0.1, color: .blue),
	.init(value: 0.6, color: .white),
	.init(value: 0.3, color: .gray),
]

Partition(values)
	.border(.clear) //sets the color of the border
	.frame(width: 200, height: 30)
```

### Styles
```swift
let values: [Partition.Value] = [
	.init(value: 0.25, color: .yellow),
	.init(value: 0.5, color: .green),
	.init(value: 0.25, color: .blue),
]

Partition(values)
	.partitionStyle(PieParitionStyle()) //presents the data as a "Pie chart"
	.frame(width: 100, height: 100)
```

Other available styles:  `DefaultPartitionStyle`, `OvalPartitionStyle`

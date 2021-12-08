//
//  PartitionStyle.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI

/// A type that applies standard interaction behavior and a custom appearance to
/// all partitions within a view hierarchy.
///
/// To configure the current parition style for a view hierarchy, use the
/// ``View/partitionStyle(_:)`` modifier. Specify a style that conforms to
/// ``PartitionStyle`` when using partition
public protocol PartitionStyle {
	
	/// A view that Represents the body of the partition
	associatedtype Body: View
	
	/// Creates a view that represents the body of a partition.
	///
	/// The system calls this method for each ``Partition`` instance in a view
	/// hierarchy where this style is the current partition style.
	///
	/// - Parameter configuration : The properties of the partition.
	func makeBody(configuration: Self.Configuration) -> Self.Body
	
	/// The properties of a partition.
	typealias Configuration = PartitionStyleConfiguration
}

internal extension PartitionStyle {
	func makeBodyTypeErased(configuration: Self.Configuration) -> AnyView {
		AnyView(self.makeBody(configuration: configuration))
	}
}

/// The properties of a Partition.
public struct PartitionStyleConfiguration {
	public let values: [Partition.Value]
	public var borderColor: Color = .primary
}

/// Type Erased PartitionStyle
public struct AnyPartitionStyle: PartitionStyle {
	private let _makeBody: (PartitionStyle.Configuration) -> AnyView
	
	init<Style>(_ style: Style) where Style: PartitionStyle {
		self._makeBody = style.makeBodyTypeErased
	}
	
	public func makeBody(configuration: PartitionStyle.Configuration) -> AnyView {
		self._makeBody(configuration)
	}
}

//MARK: - static style functions

public extension PartitionStyle where Self == DefaultPartitionStyle {
	/// A partition style that present values in a horizontal bar
	/// - Parameter radius: corner radius
	static func `default`(radius: CGFloat = 8) -> DefaultPartitionStyle {
		DefaultPartitionStyle(radius: radius)
	}
}

public extension PartitionStyle where Self == VerticalBarPartitionStyle {
	/// A partition style that present values in a vertical bar
	/// - Parameter radius: corner radius
	static func verticalBar(radius: CGFloat = 8) -> VerticalBarPartitionStyle {
		VerticalBarPartitionStyle(radius: radius)
	}
}

public extension PartitionStyle where Self == OvalPartitionStyle {
	/// A partition style that present values in an oval stoke
	/// - Parameter lineWidth: thickness of the stroke
	static func oval(lineWidth: CGFloat = 15) -> OvalPartitionStyle {
		OvalPartitionStyle(lineWidth: lineWidth)
	}
}

public extension PartitionStyle where Self == PiePartitionStyle {
	/// A partition style that present values in a pie chart
	/// - Parameter pivot: start angle of the first partition
	/// - Parameter clockwise: direction of partitions, tur is clockwise.
	static func pie(pivot: CGFloat = 0, clockwise: Bool = true) -> PiePartitionStyle {
		PiePartitionStyle(pivot: pivot, clockwise: clockwise)
	}
}

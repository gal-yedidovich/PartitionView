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
/// ``PartitionStyle`` when creating a button that uses the standard button
/// interaction behavior defined for each platform. To create a button with
/// custom interaction behavior, use ``PrimitiveButtonStyle`` instead.
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

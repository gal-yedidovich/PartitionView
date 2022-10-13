//
//  Environment.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI
public extension EnvironmentValues {
	/// The partition style for this environment
	var partitionStyle: AnyPartitionStyle {
		get { self[PartitionKey.self] }
		set { self[PartitionKey.self] = newValue }
	}
}

/// The environment key of partition style
public struct PartitionKey: EnvironmentKey {
	public static let defaultValue: AnyPartitionStyle = .init(HorizontalBarPartitionStyle())
}

extension View {
	/// Sets the style for partitions within this view to a partition style with a custom appearance and custom interaction behavior.
	/// - Parameter style: a partition style
	/// - Returns: new view including the set
	public func partitionStyle(_ style: some PartitionStyle) -> some View {
		self.environment(\.partitionStyle, AnyPartitionStyle(style))
	}
}

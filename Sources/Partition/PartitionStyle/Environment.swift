//
//  Environment.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI
public extension EnvironmentValues {
	/// The partition style for this environment
	var partitionBarStyle: AnyPartitionStyle {
		get { self[PartitionBarKey.self] }
		set { self[PartitionBarKey.self] = newValue }
	}
}

/// The environment key of partition style
public struct PartitionBarKey: EnvironmentKey {
	public static let defaultValue: AnyPartitionStyle = AnyPartitionStyle(DefaultPartitionStyle())
}

extension View {
	/// Sets the style for partitions within this view to a partition style with a custom appearance and custom interaction behavior.
	/// - Parameter style: a partition style
	/// - Returns: new view including the set
	public func partitionBarStyle<Style>(_ style: Style) -> some View where Style: PartitionStyle {
		self.environment(\.partitionBarStyle, AnyPartitionStyle(style))
	}
}

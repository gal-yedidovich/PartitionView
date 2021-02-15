//
//  Environment.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI
// MARK: - Custom Environment Key
extension EnvironmentValues {
	var partitionBarStyle: AnyPartitionBarStyle {
		get {
			return self[PartitionBarKey.self]
		}
		set {
			self[PartitionBarKey.self] = newValue
		}
	}
}

public struct PartitionBarKey: EnvironmentKey {
	public static let defaultValue: AnyPartitionBarStyle = AnyPartitionBarStyle(DefaultPartitionBarStyle())
}

// MARK: - View Extension
extension View {
	public func partitionBarStyle<S>(_ style: S) -> some View where S : PartitionBarStyle {
		self.environment(\.partitionBarStyle, AnyPartitionBarStyle(style))
	}
}

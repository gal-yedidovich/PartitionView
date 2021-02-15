//
//  PartitionBarStyle.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI
public protocol PartitionBarStyle {
	associatedtype Body: View
	
	func makeBody(configuration: Self.Configuration) -> Self.Body
	
	typealias Configuration = PartitionBarStyleConfiguration
}

extension PartitionBarStyle {
	func makeBodyTypeErased(configuration: Self.Configuration) -> AnyView {
		AnyView(self.makeBody(configuration: configuration))
	}
}

public struct PartitionBarStyleConfiguration {
	public let values: [Partition]
	public var radius: CGFloat = 8
	public var borderColor: Color = .primary
}

// MARK: - Type Erased TripleToggleStyle
public struct AnyPartitionBarStyle: PartitionBarStyle {
	private let _makeBody: (PartitionBarStyle.Configuration) -> AnyView
	
	init<Style>(_ style: Style) where Style: PartitionBarStyle {
		self._makeBody = style.makeBodyTypeErased
	}
	
	public func makeBody(configuration: PartitionBarStyle.Configuration) -> AnyView {
		self._makeBody(configuration)
	}
}

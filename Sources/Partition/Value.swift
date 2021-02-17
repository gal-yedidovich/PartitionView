//
//  Value.swift
//  
//
//  Created by Gal Yedidovich on 12/02/2021.
//

import SwiftUI
public extension Partition {
	struct Value: Identifiable {
		public let id = UUID()
		public let value: CGFloat
		public let color: Color
		
		public init(value: CGFloat, color: Color) {
			self.value = value
			self.color = color
		}
	}
}

internal typealias PartitionRange = (start: CGFloat, end: CGFloat)

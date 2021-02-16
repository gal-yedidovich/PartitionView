//
//  PartitionBar.swift
//  
//
//  Created by Gal Yedidovich on 12/02/2021.
//

import SwiftUI
public struct PartitionBar: View {
	private var config: PartitionBarStyleConfiguration
	@Environment(\.partitionBarStyle) var style: AnyPartitionBarStyle
	
	public init(_ values: [Partition]) {
		config = .init(values: values)
	}
	
	public var body: some View {
		style.makeBody(configuration: config)
	}
	
	public func border(_ color: Color) -> PartitionBar {
		var copy = self
		copy.config.borderColor = color
		return copy
	}
	
	public func cornerRadius(_ value: CGFloat) -> PartitionBar {
		var copy = self
		copy.config.radius = value
		return copy
	}
}

struct PartitionBar_Previews: PreviewProvider {
	static var previews: some View {
		DefaultPartitionBarStyle_Previews.previews
		
		PieParitionBarStyle_Previews.previews
		
		OvalPartitionBarStyle_Previews.previews
	}
}

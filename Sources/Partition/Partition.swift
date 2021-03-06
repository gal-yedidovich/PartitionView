//
//  Partition.swift
//  
//
//  Created by Gal Yedidovich on 12/02/2021.
//

import SwiftUI
public struct Partition: View {
	private var config: PartitionStyleConfiguration
	@Environment(\.partitionStyle) var style: AnyPartitionStyle
	
	public init(_ values: [Value]) {
		config = .init(values: values)
	}
	
	public var body: some View {
		style.makeBody(configuration: config)
	}
	
	public func border(_ color: Color) -> Partition {
		var copy = self
		copy.config.borderColor = color
		return copy
	}
}

struct Partition_Previews: PreviewProvider {
	static var previews: some View {
		DefaultPartitionStyle_Previews.previews
		
		PieParitionStyle_Previews.previews
		
		OvalPartitionStyle_Previews.previews
	}
}

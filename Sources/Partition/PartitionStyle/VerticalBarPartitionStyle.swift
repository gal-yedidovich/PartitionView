//
//  VerticalBarPartitionStyle.swift
//  
//
//  Created by Gal Yedidovich on 08/12/2021.
//

import SwiftUI

/// A partition style, presents the data in a vertical bar.
public struct VerticalBarPartitionStyle: PartitionStyle {
	public var radius: CGFloat = 8
	
	public func makeBody(configuration config: Configuration) -> some View {
		let values = config.values
		let borderColor = config.borderColor
		
		return GeometryReader { geo in
			VStack(spacing: 0) {
				if values.isEmpty {
					Rectangle()
						.foregroundColor(.gray.opacity(0.8))
				} else {
					let width = geo.size.height - CGFloat(values.count - 1)
					
					let first = values[0]
					first.color.frame(maxWidth: width * first.value)
					
					ForEach(values.dropFirst()) { value in
						Divider()
							.background(borderColor)
						
						value.color.frame(maxWidth: width * value.value)
					}
				}
			}
			.cornerRadius(radius)
			.overlay(
				RoundedRectangle(cornerRadius: radius)
					.strokeBorder(lineWidth: 1)
					.foregroundColor(borderColor)
			)
		}
	}
}

struct VerticalBarPartitionStyle_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Partition([])
				.frame(width: 30, height: 200)
			Partition([
				.init(value: 0.5, color: .red),
				.init(value: 0.5, color: .secondary),
			])
				.frame(width: 30, height: 200)
			
			Partition([
				.init(value: 0.5, color: .red),
				.init(value: 0.5, color: .primary),
			])
				.border(.clear)
				.frame(width: 40, height: 200)
			
			Partition([
				.init(value: 0.8, color: .blue),
			])
				.partitionStyle(.verticalBar(radius: 0))
				.frame(width: 30, height: 200)
			
			Partition([
				.init(value: 0.4, color: .green),
				.init(value: 0.4, color: .yellow),
				.init(value: 0.3, color: .red),
			])
				.frame(width: 30, height: 200)
		}
		.partitionStyle(.verticalBar())
		.padding(10)
	}
}

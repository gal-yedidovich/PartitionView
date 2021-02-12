//
//  PartitionBar.swift
//  
//
//  Created by Gal Yedidovich on 12/02/2021.
//

import SwiftUI
public struct PartitionBar: View {
	let values: [Partition]
	var radius: CGFloat = 8
	var borderColor: Color = .primary
	
	public init(_ values: [Partition]) {
		self.values = values
	}
	
	public var body: some View {
		GeometryReader { geo in
			HStack(spacing: 0) {
				if values.isEmpty {
					Rectangle()
						.foregroundColor(Color.gray.opacity(0.8))
				} else {
					let width = geo.size.width - CGFloat(values.count - 1)
					
					let first = values[0]
					Rectangle()
						.foregroundColor(first.color)
						.frame(maxWidth: width * first.value)
					
					ForEach(values.dropFirst()) { value in
						Divider()
							.background(borderColor)
						
						Rectangle()
							.foregroundColor(value.color)
							.frame(maxWidth: width * value.value)
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
	
	public func border(_ color: Color) -> PartitionBar {
		var copy = self
		copy.borderColor = color
		return copy
	}
	
	public func cornerRadius(_ value: CGFloat) -> PartitionBar {
		var copy = self
		copy.radius = value
		return copy
	}
}

struct PartitionBar_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PartitionBar([
				Partition(value: 0.5, color: .red),
				Partition(value: 0.5, color: .secondary),
			])
			.frame(width: 200, height: 40)
			
			PartitionBar([
				Partition(value: 0.5, color: .red),
				Partition(value: 0.5, color: .primary),
			])
			.border(.clear)
			.frame(width: 200, height: 40)
			
			PartitionBar([
				Partition(value: 0.8, color: .blue),
			])
			.cornerRadius(0)
			.frame(width: 250, height: 30)
			
			PartitionBar([
				Partition(value: 0.4, color: .green),
				Partition(value: 0.4, color: .yellow),
				Partition(value: 0.4, color: .red),
			])
			.frame(width: 200, height: 20)
		}
	}
}

//
//  DefaultPartitionStyle.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI
public struct DefaultPartitionStyle: PartitionStyle {
	public func makeBody(configuration: Configuration) -> some View {
		let values = configuration.values
		let radius = configuration.radius
		let borderColor = configuration.borderColor
		
		return GeometryReader { geo in
			HStack(spacing: 0) {
				if values.isEmpty {
					Rectangle()
						.foregroundColor(Color.gray.opacity(0.8))
				} else {
					let width = geo.size.width - CGFloat(values.count - 1)
					
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

struct DefaultPartitionBarStyle_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Partition([])
				.frame(width: 200, height: 30)
			Partition([
				.init(value: 0.5, color: .red),
				.init(value: 0.5, color: .secondary),
			])
			.frame(width: 200, height: 30)
			
			Partition([
				.init(value: 0.5, color: .red),
				.init(value: 0.5, color: .primary),
			])
			.border(.clear)
			.frame(width: 200, height: 40)
			
			Partition([
				.init(value: 0.8, color: .blue),
			])
			.cornerRadius(0)
			.frame(width: 200, height: 30)
			
			Partition([
				.init(value: 0.4, color: .green),
				.init(value: 0.4, color: .yellow),
				.init(value: 0.3, color: .red),
			])
			.frame(width: 200, height: 20)
		}
		.padding(10)
	}
}

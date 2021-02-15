//
//  PieParitionBarStyle.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI
public struct PieParitionBarStyle: PartitionBarStyle {
	public var pivot: CGFloat = 0
	public var clockwise = true
	
	@ViewBuilder
	public func makeBody(configuration: Configuration) -> some View {
		if configuration.values.isEmpty {
			Circle().foregroundColor(Color.gray.opacity(0.8))
		} else {
			let parts = buildAngles(configuration)
			ZStack {
				ForEach(0..<parts.count, id: \.self) { i in
					let pie = PiePart(start: parts[i].start, end: parts[i].end, clockwise: clockwise)
					
					pie.foregroundColor(configuration.values[i].color)
						.overlay(pie.strokeBorder(lineWidth: 1).foregroundColor(configuration.borderColor))
				}
			}
		}
	}
	
	private func buildAngles(_ config: Configuration) -> [AngleRange] {
		var parts: [AngleRange] = []
		
		var current = pivot.angle
		for value in config.values {
			let end = value.value.angle
			parts.append(AngleRange(start: current, end: current + end))
			current += end
		}
		
		return parts
	}
	
	private struct PiePart: InsettableShape {
		let start: Angle
		let end: Angle
		let clockwise: Bool
		var insetAmount: CGFloat = 0
		
		func path(in rect: CGRect) -> Path {
			let r = min(rect.size.width, rect.size.height) / 2
			let center = CGPoint(x: rect.midX, y: rect.midY)
			return Path { path in
				path.move(to: center)
				
				let adj = Angle(degrees: 90)
				path.addArc(center: center,
							radius: r - insetAmount,
							startAngle: start - adj,
							endAngle: end - adj,
							clockwise: !clockwise
				)
				
				path.closeSubpath()
			}
		}
		
		func inset(by amount: CGFloat) -> some InsettableShape {
			var copy = self
			copy.insetAmount += amount
			return copy
		}
	}
	
	private struct AngleRange {
		let start: Angle
		let end: Angle
	}
}

fileprivate extension CGFloat {
	var angle: Angle {
		Angle(degrees: Double(self) * 360)
	}
}

struct PieParitionBarStyle_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PartitionBar([])
			
			PartitionBar([
				Partition(value: 0.4, color: .green),
				Partition(value: 0.6, color: .orange),
			])
			
			PartitionBar([
				Partition(value: 0.33, color: .red),
				Partition(value: 0.34, color: .white),
				Partition(value: 0.33, color: .blue),
			])
			
			PartitionBar([
				Partition(value: 0.8, color: .purple),
			])
			.partitionBarStyle(PieParitionBarStyle(clockwise: false))
			
			PartitionBar([
				Partition(value: 0.9, color: .yellow),
			])
			.border(.clear)
			.partitionBarStyle(PieParitionBarStyle(pivot: 0.3))
		}
		.partitionBarStyle(PieParitionBarStyle())
		.frame(width: 100, height: 100)
		.padding(10)
	}
}

//
//  PieParitionStyle.swift
//  
//
//  Created by Gal Yedidovich on 15/02/2021.
//

import SwiftUI
/// Presents the data in a a pie chart
public struct PieParitionStyle: PartitionStyle {
	public var pivot: CGFloat = 0
	public var clockwise = true
	
	@ViewBuilder
	public func makeBody(configuration config: Configuration) -> some View {
		if config.values.isEmpty {
			Circle().foregroundColor(Color.gray.opacity(0.8))
		} else {
			let parts = buildAngles(config)
			ZStack {
				ForEach(0..<parts.count, id: \.self) { i in
					let pie = PiePart(range: parts[i], clockwise: clockwise)
					
					pie.foregroundColor(config.values[i].color)
						.overlay(pie.strokeBorder(lineWidth: 1).foregroundColor(config.borderColor))
						.transition(transition)
				}
			}
		}
	}
	
	private var transition: AnyTransition {
		let anim = Animation.default.delay(0.15)
		return AnyTransition.asymmetric(
			insertion: AnyTransition.scale.animation(anim),
			removal: AnyTransition.opacity.animation(anim)
		)
	}
	
	private func buildAngles(_ config: Configuration) -> [PartitionRange] {
		var parts: [PartitionRange] = []
		
		var current = pivot
		for value in config.values {
			let end = value.value
			parts.append(PartitionRange(start: current, end: current + end))
			current += end
		}
		
		return parts
	}
	
	private struct PiePart: InsettableShape {
		var range: PartitionRange
		let clockwise: Bool
		var insetAmount: CGFloat = 0
		
		func path(in rect: CGRect) -> Path {
			let radius = min(rect.size.width, rect.size.height) / 2
			let center = CGPoint(x: rect.midX, y: rect.midY)
			return Path { path in
				path.move(to: center)
				
				let adj = Angle(degrees: 90)
				path.addArc(center: center,
							radius: radius - insetAmount,
							startAngle: range.start.angle - adj,
							endAngle: range.end.angle - adj,
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
		
		var animatableData: AnimatablePair<CGFloat, CGFloat> {
			get { AnimatablePair(range.start, range.end) }
			set {
				range.start = newValue.first
				range.end = newValue.second
			}
		}
	}
}

fileprivate extension CGFloat {
	var angle: Angle { .degrees(Double(self) * 360) }
}

struct PieParitionStyle_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Partition([])
			
			Partition([
				.init(value: 0.4, color: .green),
				.init(value: 0.6, color: .orange),
			])
			
			Partition([
				.init(value: 0.33, color: .red),
				.init(value: 0.34, color: .white),
				.init(value: 0.33, color: .blue),
			])
			
			Partition([
				.init(value: 0.8, color: .purple),
			])
			.partitionStyle(PieParitionStyle(clockwise: false))
			
			Partition([
				.init(value: 0.9, color: .yellow),
			])
			.border(.clear)
			.partitionStyle(PieParitionStyle(pivot: 0.3))
			
			AnimatedPieExample()
		}
		.partitionStyle(PieParitionStyle())
		.frame(width: 100, height: 100)
		.padding(10)
	}
	
	private struct AnimatedPieExample: View {
		@State var expended = true
		
		var body: some View {
			let values: [Partition.Value] = expended
				? [
					.init(value: 0.2, color: .red),
					.init(value: 0.4, color: .green),
					.init(value: 0.4, color: .yellow)
				]
				: [
					.init(value: 0.9, color: .red),
					.init(value: 0.1, color: .blue)
				]
			Partition(values)
				.partitionStyle(PieParitionStyle())
				.contentShape(Circle())
				.onTapGesture {
					withAnimation {
						expended.toggle()
					}
				}
		}
	}
}

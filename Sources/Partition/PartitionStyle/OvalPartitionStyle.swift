//
//  OvalPartitionStyle.swift
//  
//
//  Created by Gal Yedidovich on 16/02/2021.
//

import SwiftUI
public struct OvalPartitionStyle: PartitionStyle {
	public var lineWidth: CGFloat = 15
	
	@ViewBuilder
	public func makeBody(configuration config: Configuration) -> some View {
		if config.values.isEmpty {
			let color = config.values.first?.color ?? Color.gray.opacity(0.8)
			Circle()
				.stroke(lineWidth: lineWidth)
				.foregroundColor(color)
				.padding(lineWidth / 2)
				.transition(AnyTransition.opacity.animation(.default))
		} else {
			let parts = buildParts(config)
			ZStack {
				ForEach(0..<parts.count, id: \.self) { index in
					let start = parts[index].start
					let end = parts[index].end
					
					Circle()
						.trim(from: start, to: end)
						.stroke(lineWidth: lineWidth)
						.rotationEffect(.degrees(-90))
						.foregroundColor(config.values[index].color)
						.padding(lineWidth / 2)
						.transition(AnyTransition.ovalClip(lineWidth: lineWidth, start: start, end: end).animation(.default))
						.zIndex(Double(index))
				}
			}
		}
	}
	
	private func buildParts(_ config: Configuration) -> [PartitionRange] {
		var parts: [PartitionRange] = []

		var current: CGFloat = .zero
		for partition in config.values {
			let end = partition.value
			parts.append(PartitionRange(start: current, end: current + end))
			current += end
		}
		
		return parts
	}
}

fileprivate struct TrimmedOval: Shape {
	var lineWidth: CGFloat
	var start: CGFloat
	var end: CGFloat
	
	var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>> {
		get { AnimatablePair(lineWidth, AnimatablePair(start, end)) }
		set {
			lineWidth = newValue.first
			start = newValue.second.first
			end = newValue.second.second
		}
	}
	
	func path(in rect: CGRect) -> Path {
		return Circle()
			.rotation(.degrees(-90))
			.trim(from: start, to: end)
			.stroke(lineWidth: lineWidth * 2)
			.path(in: rect)
	}
}

fileprivate struct ClipShapeModifier<ClipShape: Shape>: ViewModifier {
	let shape: ClipShape
	
	func body(content: Content) -> some View {
		content.clipShape(shape)
	}
}

fileprivate extension AnyTransition {
	static func ovalClip(lineWidth: CGFloat, start: CGFloat, end: CGFloat) -> AnyTransition {
		.modifier(
			active: ClipShapeModifier(shape: TrimmedOval(lineWidth: lineWidth, start: end, end: end)),
			identity: ClipShapeModifier(shape: TrimmedOval(lineWidth: lineWidth, start: start, end: end))
		)
	}
}

struct OvalPartitionBarStyle_Previews: PreviewProvider {
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
			
			Partition([
				.init(value: 0.9, color: .yellow),
			])
			.border(.clear)
			.partitionBarStyle(OvalPartitionStyle())
			
			AnimatedOvalExample()
		}
		.padding(10)
		.frame(width: 100, height: 100)
		.partitionBarStyle(OvalPartitionStyle())
	}
	
	private struct AnimatedOvalExample: View {
		@State var expended = true
		
		var body: some View {
			let values: [Partition.Value] = expended
				? [
					.init(value: 0.2, color: .red),
					.init(value: 0.4, color: .green),
					.init(value: 0.4, color: .yellow)
				]
				: [
					
					.init(value: 0.3, color: .red),
					.init(value: 0.7, color: .green),
				]
			VStack {
				Partition(values)
					.partitionBarStyle(OvalPartitionStyle(lineWidth: 10))
					.contentShape(Circle())
				
				Spacer()
				
				Button("animate") {
					withAnimation {
						expended.toggle()
					}
				}
			}
		}
	}
}

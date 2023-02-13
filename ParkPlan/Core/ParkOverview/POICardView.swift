//
//  POICardView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import SwiftUI

struct POICardView: View {
	let name: String
	let liveDataString: String
	let liveDataColor: Color
	let type: EntityType?

	init(name: String, liveDataString: String, color: Color, type: EntityType? = nil) {
		self.name = name
		self.liveDataString = liveDataString
		self.liveDataColor = color
		self.type = type
	}

	var typeColor: Color {
		switch type {
		case .attraction:
			return .blue
		case .show:
			return .orange
		case .restaurant:
			return .indigo
		default:
			return .red
		}
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			title

			HStack(alignment: .center) {
				if !liveDataString.isEmpty {
					LiveDataTagView(text: liveDataString, color: liveDataColor)
				}
				
				Spacer()

				switch type {
				case .attraction:
					Image(systemName: "seal.fill")
						.font(.title)
						.foregroundStyle(liveDataColor.gradient)
				case .show:
					Image(systemName: "theatermasks.fill")
						.font(.title)
						.foregroundStyle(liveDataColor.gradient)
				case .restaurant:
					Image(systemName: "fork.knife")
						.font(.title)
						.foregroundStyle(liveDataColor.gradient)
				default:
					EmptyView()
				}

			}
		}
		.cardBackground(liveDataColor)
	}
}

struct POICardView_Previews: PreviewProvider {
	static var previews: some View {
		POICardView(name: "Hagrid's Magical Creatures Motorbike Adventure™", liveDataString: "100 min wait", color: .pink)
			.padding()
			.previewLayout(.sizeThatFits)
			.previewDisplayName("Card Long Name")

		POICardView(name: "Hog's Head™", liveDataString: "Open", color: .green, type: EntityType.attraction)
			.padding()
			.previewLayout(.sizeThatFits)
			.previewDisplayName("Card Short Name")
	}
}

// MARK: - Custom Views
private extension POICardView {
	var title: some View {
		Text(name)
			.foregroundStyle(liveDataColor.shadow(.inner(radius: 10)))
			.lineLimit(3)
			.frame(maxWidth: .infinity, alignment: .leading)
			.frame(maxHeight: .infinity, alignment: .top)
//			.font(.largeTitle)
			.font(.system(.largeTitle, design: .rounded, weight: .bold))
//			.bold()
			.minimumScaleFactor(0.5)
			.padding(.top, 1)
	}
}

// MARK: - Custom Modifiers
struct CardBackground: ViewModifier {
	let color: Color

	func body(content: Content) -> some View {
		content
			.dynamicTypeSize(.medium)
			.frame(width: 200, height: 110)
			.padding(12)
			.background(color.gradient.opacity(0.2), in: RoundedRectangle(cornerRadius: 15))
	}
}

extension View {
	/// Place this view in a filled, rounded rectangle.
	/// - Parameter color: Background color of view. Default: '.gray'
	func cardBackground(_ color: Color = .gray) -> some View {
		modifier(CardBackground(color: color))
	}
}



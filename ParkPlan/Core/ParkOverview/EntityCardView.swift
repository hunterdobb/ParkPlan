//
//  EntityCardView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import SwiftUI

struct EntityCardView: View {
	@EnvironmentObject private var vm: ParkOverviewViewModel
	let poi: EntityLiveData
	// These default values will be overwritten in .onAppear
	@State private var name: String = ""
	@State private var liveDataString: String = ""
	@State private var liveDataColor: Color = .green
	@State private var type: EntityType? = .attraction


//	init(poi: EntityChild, liveDataString: String, liveDataColor: Color) {
//		self.name = poi.name
//		self.liveDataString = liveDataString
//		self.liveDataColor = liveDataColor
//		self.type = poi.entityType
//	}


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
		.onAppear {
			name = poi.name
			liveDataString = vm.standbyWaitText(id: poi.id)
			liveDataColor = vm.getColorForLiveData(text: liveDataString)
			type = poi.entityType
		}
	}
}

//struct POICardView_Previews: PreviewProvider {
//	static var previews: some View {
//		let previewPOI1 = EntityChild(id: "578bbd12-1975-4ec3-9879-ea641c780342",
//									 name: "Hagrid's Magical Creatures Motorbike Adventure™",
//									 entityType: .attraction,
//									 slug: nil,
//									 externalId: "17097")
//
//		let previewPOI2 = EntityChild(id: "7863937e-bb65-408b-9652-c9700c923c9c",
//									 name: "Hog's Head™",
//									 entityType: .restaurant,
//									 slug: nil,
//									 externalId: "11632")
//
//		Group {
//			EntityCardView(poi: previewPOI1)
//				.padding()
//				.previewLayout(.sizeThatFits)
//				.previewDisplayName("Card Long Name")
//
//			EntityCardView(poi: previewPOI2)
//				.padding()
//				.previewLayout(.sizeThatFits)
//				.previewDisplayName("Card Short Name")
//		}
//		.environmentObject(ParkOverviewViewModel(park: DestinationParkEntry(id: "267615cc-8943-4c2a-ae2c-5da728ca591f", name: "Universal's Islands of Adventure")))
//	}
//}

// MARK: - Custom Views
private extension EntityCardView {
	var title: some View {
		Text(name)
			.foregroundStyle(liveDataColor.shadow(.inner(radius: 10)))
			.lineLimit(3)
			.frame(maxWidth: .infinity, alignment: .leading)
			.frame(maxHeight: .infinity, alignment: .top)
			.font(.system(.largeTitle, design: .rounded, weight: .bold))
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



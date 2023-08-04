//
//  ParkRowView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 7/23/23.
//

import SwiftUI

struct ParkRowView: View {
	let park: Park

    var body: some View {
		NavigationLink {
			#if os(iOS)
			ParkOverviewView()
				.environmentObject(ParkOverviewViewModel(park: park))
			#elseif os(watchOS)
			ParkDetailView(park: park, entityType: .attraction)
			#endif
		} label: {
			VStack(alignment: .leading) {
				Text(park.name)
					.font(.system(.title, design: .rounded, weight: .heavy))

				HStack {
					Text("8:00 AM - 9:30 PM")
				}.font(.headline)
			}
			.foregroundStyle(.white)
		}
		.listRowBackground(
			RoundedRectangle(cornerRadius: 20, style: .continuous)
				.foregroundStyle(color.gradient)
				.padding(.horizontal)
		)
		#if !os(watchOS)
		.listRowSeparator(.hidden)
		#endif

    }

	var color: Color {
		switch park.name {
		case "Magic Kingdom": return .blue
		case "EPCOT": return .purple
		case "Hollywood Studios": return .orange
		case "Animal Kingdom": return .green
		default: return .blue
		}
	}
}

//#Preview {
//	NavigationStack {
//		List {
//			ParkRowView(
//				park: DestinationParkEntry(
//					id: "75ea578a-adc8-4116-a54d-dccb60765ef9",
//					name: "Magic Kingdom Park"
//				)
//			)
//		}
//	}
//}

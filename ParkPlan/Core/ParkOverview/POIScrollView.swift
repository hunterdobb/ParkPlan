//
//  POIScrollView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import SwiftUI

struct POIScrollView: View {
	let title: String
	let symbolName: String
	
	@EnvironmentObject private var vm: ParkOverviewViewModel
	let data: [EntityChild]
	let typeColor: Color
	let entityType: EntityType



    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			header

			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					if !data.isEmpty {
						ForEach(data) { poi in
							POICardView(poi: poi)
						}

						NavigationLink("View All", destination: ParkDetailView(park: vm.park, entityType: entityType))
							.buttonStyle(.borderedProminent)
							.font(.headline)
					} else {
						noData
					}
				}
				.padding(.horizontal)
			}
		}
		.padding(.bottom)
    }
}

// MARK: - Preview
struct POIScrollView_Previews: PreviewProvider {
    static var previews: some View {
		let previewPark = DestinationParkEntry(id: "75ea578a-adc8-4116-a54d-dccb60765ef9", name: "Magic Kingdom Park")
		let previewVm = ParkOverviewViewModel(park: previewPark)
		POIScrollView(title: "Shows", symbolName: "theatermasks.fill", data: previewVm.updatedAttractions, typeColor: .orange, entityType: .attraction)
			.environmentObject(ParkOverviewViewModel(park: previewPark))
			.task {
				await previewVm.fetchLiveData(for: previewVm.park.id)
				await previewVm.fetchChildren(for: previewVm.park.id)
			}
    }
}

// MARK: - Custom Views
private extension POIScrollView {
	var header: some View {
		NavigationLink {
//			vm.selection = entityType
			ParkDetailView(park: vm.park, entityType: entityType)
		} label: {
			HStack(alignment: .center, spacing: 5) {
				Image(systemName: symbolName)
					.font(.system(.title2))

				Text(title)

				Image(systemName: "chevron.forward")
					.font(.system(.headline, weight: .bold))
					.foregroundColor(typeColor.opacity(0.6))
			}
			.foregroundStyle(typeColor.gradient)
			.font(.system(.title2, design: .rounded, weight: .heavy))
		}
		.padding(.leading, 20)

	}

//	var tempData: some View {
//		HStack {
//			POICardView(name: "The High in the Sky Seuss Trolley Train Ride!™", liveDataString: "5 min wait", color: .green)
//			POICardView(name: "Hagrid's Magical Creatures Motorbike Adventure™", liveDataString: "100 min wait", color: .pink)
//			POICardView(name: "Jurassic World VelociCoaster", liveDataString: "50 min wait", color: .orange)
//			POICardView(name: "Hog's Head™", liveDataString: "Open", color: .green)
//		}
//		.padding(.horizontal)
//	}

	var noData: some View {
		Text("No \(title)")
			.padding()
			.background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
			.font(.system(.headline, design: .rounded))
	}
}

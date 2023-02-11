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
	
	@ObservedObject var vm: ParkDataViewModel
	let parkID: String
	let data: [EntityChild]
	let typeColor: Color



    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			header

			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					if !data.isEmpty {
						ForEach(data) { poi in
							let liveData = vm.standbyWaitText(for: poi)
							POICardView(name: poi.name, liveDataString: liveData, color: vm.getColorForLiveData(text: liveData), type: poi.entityType)
						}

						NavigationLink(destination: ParkDataView(parkId: parkID)) {
							POICardView(name: "View All", liveDataString: "", color: .blue)
						}
					} else {
						Text("No \(title)")
							.padding()
							.background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
							.font(.system(.headline, design: .rounded))
//						POICardView(name: "No \(title)", liveDataString: "", color: .gray)
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
		let previewVm = ParkDataViewModel()
		let previewParkId = "buschgardenstampa"
		POIScrollView(title: "Shows", symbolName: "theatermasks.fill", vm: previewVm, parkID: previewParkId, data: previewVm.updatedAttractions, typeColor: .orange)
			.task {
				await previewVm.fetchLiveData(for: previewParkId)
				await previewVm.fetchChildren(for: previewParkId)
			}
    }
}

// MARK: - Custom Views
private extension POIScrollView {
	var header: some View {
		NavigationLink {
			ParkDataView(parkId: parkID)
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

	var tempData: some View {
		HStack {
			POICardView(name: "The High in the Sky Seuss Trolley Train Ride!™", liveDataString: "5 min wait", color: .green)
			POICardView(name: "Hagrid's Magical Creatures Motorbike Adventure™", liveDataString: "100 min wait", color: .pink)
			POICardView(name: "Jurassic World VelociCoaster", liveDataString: "50 min wait", color: .orange)
			POICardView(name: "Hog's Head™", liveDataString: "Open", color: .green)
		}
		.padding(.horizontal)
	}
}

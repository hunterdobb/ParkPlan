//
//  ParkOverviewView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import SwiftUI

struct ParkOverviewView: View {
	@EnvironmentObject private var vm: ParkOverviewViewModel

	@State private var hasAppeared = false

//	init(park: DestinationParkEntry) {
//		_vm = StateObject(wrappedValue: ParkOverviewViewModel(park: park))
//		_vm = EnvironmentObject(ParkOverviewViewModel(park: park))
//	}

    var body: some View {
		ScrollView {
			POIScrollView(title: "Favorites", symbolName: "heart.fill",
						  data: [], typeColor: .red, entityType: .attraction).padding(.top)

			let attractions = Array(vm.operatingAttractions.prefix(5))
			POIScrollView(title: "Attractions", symbolName: "seal.fill", data: attractions, typeColor: .blue, entityType: .attraction)

			let shows = Array(vm.operatingShows.prefix(5))
			POIScrollView(title: "Shows", symbolName: "theatermasks.fill", data: shows, typeColor: .orange, entityType: .show)

			let restaurants = Array(vm.restaurants.prefix(5))
			POIScrollView(title: "Restaurants", symbolName: "fork.knife", data: restaurants, typeColor: .indigo, entityType: .restaurant)
		}
		.navigationTitle(vm.park.name)
		.task {
			if !hasAppeared {
				print("Overview RUN")
				await vm.fetchLiveData(for: vm.park.id)
				await vm.fetchChildren(for: vm.park.id)
				hasAppeared = true
			}
		}
    }
}

struct ParkOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
			// DestinationParkEntry
			let previewPark = DestinationParkEntry(id: "75ea578a-adc8-4116-a54d-dccb60765ef9", name: "Magic Kingdom Park")
        	ParkOverviewView()
				.environmentObject(ParkOverviewViewModel(park: previewPark))
        }
    }
}

private extension ParkOverviewView {

}

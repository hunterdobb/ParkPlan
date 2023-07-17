//
//  ParkOverviewView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import OSLog
import SwiftUI

struct ParkOverviewView: View {
	@EnvironmentObject private var vm: ParkOverviewViewModel
	@State private var hasAppeared = false
	let logger = Logger(subsystem: "ParkPlan", category: "ParkOverviewView")

    var body: some View {
		ScrollView {
			Text("Open until 10:00 PM").frame(maxWidth: .infinity, alignment: .leading)
				.padding(.leading)
			favoriteSection
			attractionSection
			showSection
			restaurantSection
		}
		.navigationTitle(vm.park.name)
		.task {
			if !hasAppeared {
				logger.log(level: .info, "Fetching live data and children entities")
				await vm.fetchLiveData(for: vm.park.id)
				await vm.fetchChildren(for: vm.park.id)
				hasAppeared = true
			}
		}
		.alert(isPresented: $vm.hasError, error: vm.error) {
			Button("Retry") {
				Task {
					await vm.fetchLiveData(for: vm.park.id)
					await vm.fetchChildren(for: vm.park.id)
				}
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
	var favoriteSection: some View {
		POIScrollView(title: "Favorites",
					  symbolName: "heart.fill",
					  data: [],
					  typeColor: .red,
					  entityType: .attraction)
		.padding(.top)
	}

	var attractionSection: some View {
		let attractions = Array(vm.operatingAttractions.prefix(5))
		return POIScrollView(title: "Attractions",
							 symbolName: "seal.fill",
							 data: attractions,
							 typeColor: .blue,
							 entityType: .attraction)
	}

	var showSection: some View {
		let shows = Array(vm.operatingShows.prefix(5))
		return POIScrollView(title: "Shows",
							 symbolName: "theatermasks.fill",
							 data: shows,
							 typeColor: .orange,
							 entityType: .show)
	}

	var restaurantSection: some View {
		let restaurants = Array(vm.restaurants.prefix(5))
		return POIScrollView(title: "Restaurants",
							 symbolName: "fork.knife",
							 data: restaurants,
							 typeColor: .indigo,
							 entityType: .restaurant)
	}
}

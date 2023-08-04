//
//  ParkOverviewView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

//import OSLog
import SwiftUI

struct ParkOverviewView: View {
	@EnvironmentObject private var vm: ParkOverviewViewModel
	@State private var hasAppeared = false

	@EnvironmentObject var dataService: DisneyDataService


    var body: some View {
		ScrollView {
			if let schedule = dataService.getOperatingHours(for: vm.park.schedule) {
				Text(schedule)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding([.leading, .bottom])
			} else {
				Text("0:00 AM - 0:00 PM")
					.padding([.leading, .bottom])
			}

//			favoriteSection
			attractionSection
			showSection
			restaurantSection
		}
		.navigationTitle(vm.park.name)
		.task {
			if !hasAppeared {
				await vm.fetchData()
				hasAppeared = true
			}
		}
		.alert(isPresented: $vm.hasError, error: vm.error) {
			Button("Retry") {
				Task { await vm.fetchData() }
			}
		}
    }
}

//struct ParkOverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//			let previewPark = Park(
//				id: "75ea578a-adc8-4116-a54d-dccb60765ef9",
//				name: "Magic Kingdom Park"
//			)
//        	ParkOverviewView()
//				.environmentObject(ParkOverviewViewModel(park: previewPark))
//        }
//    }
//}

private extension ParkOverviewView {
	var favoriteSection: some View {
		EntitiesScrollView(title: "Favorites",
					  symbolName: "heart.fill",
					  data: [],
					  typeColor: .red,
					  entityType: .attraction)

	}

	var attractionSection: some View {
		let attractions = Array(vm.operatingAttractions.prefix(5))
		return EntitiesScrollView(title: "Attractions",
							 symbolName: "seal.fill",
							 data: attractions,
							 typeColor: .blue,
							 entityType: .attraction)
	}

	var showSection: some View {
		let shows = Array(vm.operatingShows.prefix(5))
		return EntitiesScrollView(title: "Shows",
							 symbolName: "theatermasks.fill",
							 data: shows,
							 typeColor: .orange,
							 entityType: .show)
	}

	var restaurantSection: some View {
		let restaurants = Array(vm.restaurants.prefix(5))
		return EntitiesScrollView(title: "Restaurants",
							 symbolName: "fork.knife",
							 data: restaurants,
							 typeColor: .indigo,
							 entityType: .restaurant)
	}
}

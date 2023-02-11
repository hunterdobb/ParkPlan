//
//  ParkOverviewView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import SwiftUI

struct ParkOverviewView: View {
	@StateObject private var vm = ParkDataViewModel()
	let parkId: String
	let parkName: String

    var body: some View {
		ScrollView {
			POIScrollView(title: "Favorites", symbolName: "heart.fill", vm: vm, parkID: parkId,
						  data: [], typeColor: .red).padding(.top)

			POIScrollView(title: "Attractions", symbolName: "seal.fill", vm: vm, parkID: parkId,
						  data: Array(vm.operatingAttractions.prefix(5)), typeColor: .blue)

			POIScrollView(title: "Shows", symbolName: "theatermasks.fill", vm: vm, parkID: parkId,
						  data: Array(vm.operatingShows.prefix(5)), typeColor: .orange)
			
			POIScrollView(title: "Restaurants", symbolName: "fork.knife", vm: vm, parkID: parkId,
						  data: Array(vm.restaurants.prefix(5)), typeColor: .indigo)
		}
		.navigationTitle(parkName)
		.task {
			await vm.fetchLiveData(for: parkId)
			await vm.fetchChildren(for: parkId)
		}
    }
}

struct ParkOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
        	ParkOverviewView(parkId: "75ea578a-adc8-4116-a54d-dccb60765ef9", parkName: "Magic Kingdom Park")
        }
    }
}

private extension ParkOverviewView {

}

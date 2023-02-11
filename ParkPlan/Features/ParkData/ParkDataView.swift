//
//  ParkDataView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/5/23.
//

import SwiftUI

struct ParkDataView: View {
	@StateObject private var vm = ParkDataViewModel()
	let parkId: String

    var body: some View {
		List {
			Section("Attractions") {
				ForEach(vm.updatedAttractions) { attraction in
					HStack {
						Text(attraction.name)
						Spacer()
						let liveData = vm.standbyWaitText(for: attraction)
						Text(liveData)
							.foregroundColor(.white)
							.font(.headline)
							.padding(.vertical, 8)
							.padding(.horizontal)
							.background(vm.getColorForLiveData(text: liveData), in: RoundedRectangle(cornerRadius: 5))
						
					}
					.swipeActions(allowsFullSwipe: false) {
						Button {} label: {
							if let dateLastUpdated = vm.dateLastUpdated(id: attraction.id) {
								Text(dateLastUpdated, format: .relative(presentation: .numeric, unitsStyle: .wide))
							}
						}
					}
				}

				if !vm.attractionsWithNoLiveData.isEmpty {
					NavigationLink {
						List {
							ForEach(vm.attractionsWithNoLiveData) { attraction in
								HStack {
									Text(attraction.name)
								}
							}
						}
						.navigationTitle("No Live Data")
					} label: {
						Text("View Attractions With No Live Data")
					}
				}
			}



			if !vm.shows.isEmpty {
				Section("Shows") {
					ForEach(vm.shows) { show in
						HStack {
							Text(show.name)
							Spacer()
							Text(vm.standbyWaitText(for: show))
						}
						.swipeActions(allowsFullSwipe: false) {
							Button {} label: {
								if let dateLastUpdated = vm.dateLastUpdated(id: show.id) {
									Text(dateLastUpdated, format: .relative(presentation: .numeric, unitsStyle: .wide))
								}
							}
						}
					}
				}
			}

			Section("Restaurant") {
				ForEach(vm.restaurants) { child in
					HStack {
						Text(child.name)
						Spacer()
						Text(vm.standbyWaitText(for: child))
					}
				}
			}
		}
		.navigationTitle("Park Data")
		.task {
			await vm.fetchLiveData(for: parkId)
			await vm.fetchChildren(for: parkId)
		}
    }
}

struct ParkDataView_Previews: PreviewProvider {
    static var previews: some View {
//			let uniStudios = "eb3f4560-2383-4a36-9152-6b3e5ed6bc57"
//			let magicKingdom = "75ea578a-adc8-4116-a54d-dccb60765ef9"
//			let epcot = "47f90d2c-e191-4239-a466-5892ef59a88b"
			let buschGardTampa = "fc40c99a-be0a-42f4-a483-1e939db275c2"

        ParkDataView(parkId: buschGardTampa)
    }
}

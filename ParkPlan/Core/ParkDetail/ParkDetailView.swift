//
//  ParkDetailView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/5/23.
//

import SwiftUI

struct ParkDetailView: View {
	@StateObject private var vm = ParkDetailViewModel()
	let park: DestinationParkEntry
	let entityType: EntityType

	@State private var hasAppeared = false

    var body: some View {
		List {
			#if os(watchOS)
			typePicker
			#endif

			ForEach(vm.children) { poi in
				if poi.entityType == vm.selection,
				   vm.dataIsUpdated(for: poi) {
					NavigationLink {
						let poiLiveData = vm.liveData?.first(where: { $0.id == poi.id })
						ItemDetailView(name: poi.name, id: poi.id, liveData: poiLiveData)
					} label: {
						dataRow(poi: poi)
							.swipeActions(allowsFullSwipe: false) {
								lastUpdatedButton(id: poi.id)
							}
					}
				}
			}

			if !vm.attractionsWithNoLiveData.isEmpty {
				noLiveDataList
			}
		}
		.navigationTitle(park.name)
		.task {
			if !hasAppeared {
				print("ParkData RUN")
				await vm.fetchLiveData(for: park.id)
				await vm.fetchChildren(for: park.id)
				hasAppeared = true
			}
		}
		.alert(isPresented: $vm.hasError, error: vm.error) {
			retryButton
		}
		.refreshable {
			await vm.fetchLiveData(for: park.id)
		}
		.onAppear {
			vm.selection = entityType
		}
		#if !os(watchOS)
		.toolbar {
			ToolbarItem {
				typePicker
			}
		}
		#endif
    }
}

struct ParkDataView_Previews: PreviewProvider {
    static var previews: some View {
		let previewPark = DestinationParkEntry(id: "75ea578a-adc8-4116-a54d-dccb60765ef9", name: "Magic Kingdom Park")

        NavigationStack {
			ParkDetailView(park: previewPark, entityType: .attraction)
        }
    }
}

private extension ParkDetailView {
	var typePicker: some View {
		Picker(selection: $vm.selection) {
			ForEach(EntityType.allCases, id: \.self) { type in
				if vm.hasType(type) {
					Text("\(type.rawValue.capitalized)s")
						.tag(type)
				}
			}
		} label: {
			Text("Viewing")
				.foregroundColor(.cyan)
		}
	}

	func dataRow(poi: EntityChild) -> some View {
		let liveData = vm.standbyWaitText(for: poi)
		return ParkDetailRow(name: poi.name,
					  liveData: liveData,
					  color: vm.getColorForLiveData(text: liveData))
	}

	func lastUpdatedButton(id: String) -> some View {
		Button {} label: {
			if let dateLastUpdated = vm.dateLastUpdated(id: id) {
				Text(dateLastUpdated, format: .relative(presentation: .numeric, unitsStyle: .wide))
			}
		}
	}

	var noLiveDataList: some View {
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
				.foregroundColor(.blue)
		}
	}

	var retryButton: some View {
		Button("Retry") {
			Task {
				await vm.fetchLiveData(for: park.id)
				await vm.fetchChildren(for: park.id)
			}
		}
	}
}

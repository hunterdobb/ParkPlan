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
//	let parkId: String
	let entityType: EntityType

	@State private var hasAppeared = false

//	init(children: [EntityChild], liveData: [EntityLiveData]?, entityType: EntityType) {
//		_vm = StateObject(wrappedValue: ParkDetailViewModel(children: children, liveData: liveData))
//		self.entityType = entityType
//	}

    var body: some View {
		List {
			#if os(watchOS)
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
			#endif

			if let children = vm.children {
				ForEach(children) { poi in
					if poi.entityType == vm.selection,
					   vm.dataIsUpdated(for: poi)
					{
						HStack {
							Text(poi.name)
							Spacer()
							let liveData = vm.standbyWaitText(for: poi)
							Text(liveData)
								.foregroundColor(.white)
								.font(.headline)
								.padding(.vertical, 8)
								.padding(.horizontal)
								.background(vm.getColorForLiveData(text: liveData), in: RoundedRectangle(cornerRadius: 5))

						}
						.swipeActions(allowsFullSwipe: false) {
							Button {} label: {
								if let dateLastUpdated = vm.dateLastUpdated(id: poi.id) {
									Text(dateLastUpdated, format: .relative(presentation: .numeric, unitsStyle: .wide))
								}
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
							.foregroundColor(.blue)
					}
				}
			} else {
				ProgressView()
			}
		}
		.navigationTitle(park.name)
		.task {
			if !hasAppeared {
				print("ParkData RUN")
				await vm.fetchLiveData(for: park.id)
				await vm.fetchChildren(for: park.id)
			}
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
				Picker("Type", selection: $vm.selection) {
					ForEach(EntityType.allCases, id: \.self) { type in
						if vm.hasType(type) {
							Text("\(type.rawValue.capitalized)s")
								.tag(type)
						}
					}
				}
			}
		}
		#endif
    }
}

struct ParkDataView_Previews: PreviewProvider {
    static var previews: some View {
		let previewPark = DestinationParkEntry(id: "75ea578a-adc8-4116-a54d-dccb60765ef9", name: "Magic Kingdom Park")

//			let magicKingdom = "75ea578a-adc8-4116-a54d-dccb60765ef9"
//			let buschGardTampa = "fc40c99a-be0a-42f4-a483-1e939db275c2"

        NavigationStack {
			ParkDetailView(park: previewPark, entityType: .attraction)
        }
    }
}

//
//  ParkView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct ParkView: View {
    @StateObject private var vm = RidesViewModel()
    let parkId: String

    var body: some View {
        List {
            if let rides = vm.rides {
                ForEach(rides) { ride in
                    if ride.entityType == vm.selection
						&& Calendar.current.isDate(.now, equalTo: ride.lastUpdated, toGranularity: .month)
					{
                        RideWaitRow(ride: ride)
							.swipeActions(allowsFullSwipe: false) {
								Button {} label: {
									Text(ride.lastUpdated, format: .relative(presentation: .numeric, unitsStyle: .wide))
								}
							}
					}
                }

            } else {
                ProgressView()
            }
        }
        .navigationTitle("Park")
        .alert(isPresented: $vm.hasError, error: vm.error) {
//            Button("Retry") {
//                vm.fetchRides(for: parkId)
//            }
        }
        .task {
            await vm.fetchRides(for: parkId)
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Picker("Type", selection: $vm.selection) {
                    ForEach(EntityType.allCases, id: \.self) { type in
                        if vm.hasType(type) {
                            Text("\(type.rawValue.capitalized)s")
                                .tag(type)
                        }
                    }
                }

				Button {
					Task {
						await vm.fetchRides(for: parkId)
					}
				} label: {
					Image(systemName: "arrow.clockwise")
				}
				.disabled(vm.isLoading)
            }
        }
    }
}

struct ParkView_Previews: PreviewProvider {

    static var previews: some View {
		let busch = "fc40c99a-be0a-42f4-a483-1e939db275c2"
//        let ioaId = "267615cc-8943-4c2a-ae2c-5da728ca591f"
//        let magicKingId = "75ea578a-adc8-4116-a54d-dccb60765ef9"
        NavigationStack {
            ParkView(parkId: busch)
        }
    }
}

private extension ParkView {

}

//
//  DestinationsView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct DestinationsView: View {
	// Uses @EnvironmentObject to easily pass vm to child views
	@EnvironmentObject private var vm: DestinationsViewModel

//    @StateObject private var vm = DestinationsViewModel()

	@State private var hasAppeared = false

    var body: some View {
        NavigationStack {
			if vm.isLoading {
				ProgressView {
					Text("Loading Destinations")
				}
			} else {
				List {
					ForEach(vm.searchResults) { destination in
						ParksList(destination: destination)
					}

				}
				.searchable(text: $vm.searchText)
				.navigationTitle("Destinations")

			}
        }

		.task {
			if !hasAppeared {
				print("RUN")
				await vm.fetchDestinations()
				hasAppeared = true
			}
		}
		.alert(isPresented: $vm.hasError, error: vm.error) {
			Button("Retry") {
				Task {
					await vm.fetchDestinations()
				}
			}
		}
    }
}

struct DestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationsView()
		// TODO: Improve preview code to match SwiftfulCrypto code
			.environmentObject(DestinationsViewModel())
    }
}

extension DestinationsView {
    func testStaticData() {
        print("DestinationsResponse")
        dump(
            try? StaticJSONMapper.decode(file: "DestinationsStaticData", type: DestinationsResponse.self)
        )

        print("\n\nSingleDestinationData")
        dump(
            try? StaticJSONMapper.decode(file: "SingleDestinationData", type: EntityData.self)
        )

        print("\n\nUniversalsIOAChildrenResponse")
        dump(
            try? StaticJSONMapper.decode(file: "UniversalIOAChildrenResponse", type: EntityChildrenResponse.self)
        )
    }
}

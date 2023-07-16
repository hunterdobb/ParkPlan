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

	@State private var hasAppeared = false

    var body: some View {
        NavigationStack {
			if vm.isLoading {
				ProgressView {
					Text("Loading Destinations")
				}
			} else {
				List {
					#if os(watchOS)
					clearSearch
					#endif

					ForEach(vm.searchResults) { destination in
						ParksList(destination: destination)
					}
				}
				.navigationTitle("Destinations")
				#if !os(watchOS)
				.searchable(text: $vm.searchText, placement: .navigationBarDrawer(displayMode: .always))
				#else
				.searchable(text: $vm.searchText)
				#endif
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

private extension DestinationsView {
	@ViewBuilder
	var clearSearch: some View {
		if !vm.searchText.isEmpty {
			Button {
				vm.searchText = ""
			} label: {
				HStack {
					Image(systemName: "xmark")
						.foregroundColor(.blue)
					Text("Clear Search")
				}

			}
		}
	}
}

//extension DestinationsView {
//    func testStaticData() {
//        print("DestinationsResponse")
//        dump(
//            try? StaticJSONMapper.decode(file: "DestinationsStaticData", type: DestinationsResponse.self)
//        )
//
//        print("\n\nSingleDestinationData")
//        dump(
//            try? StaticJSONMapper.decode(file: "SingleDestinationData", type: EntityData.self)
//        )
//
//        print("\n\nUniversalsIOAChildrenResponse")
//        dump(
//            try? StaticJSONMapper.decode(file: "UniversalIOAChildrenResponse", type: EntityChildrenResponse.self)
//        )
//    }
//}

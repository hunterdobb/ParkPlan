//
//  DestinationsView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct DestinationsView: View {
//	@EnvironmentObject private var vm: DestinationsViewModel
	@StateObject var vm = DestinationsViewModel()
	@State private var hasAppeared = false

    var body: some View {
        NavigationStack {
			if vm.isLoading {
				ProgressView { Text("Loading Destinations") }
			} else {
				List {
					#if os(watchOS)
					clearSearch
					#endif

					ForEach(vm.filteredDestinations, content: ParksList.init)
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
				await vm.fetchDestinations()
				hasAppeared = true
			}
		}
		.alert(isPresented: $vm.hasError, error: vm.error) {
			Button("Retry") {
				Task { await vm.fetchDestinations() }
			}
		}
    }
}

#Preview {
	DestinationsView()
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

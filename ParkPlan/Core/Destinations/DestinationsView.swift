//
//  DestinationsView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct DestinationsView: View {
	let parks = Bundle.main.decode("DisneyDestinations.json", as: DestinationEntry.self).parks

	var body: some View {
		NavigationStack {
			List {
				ForEach(parks, content: ParkRowView.init)
					.listRowInsets(.init(top: 15, leading: 30, bottom: 15, trailing: 30))

			}
			.navigationTitle("Disney World")
			#if !os(watchOS)
			.listRowSpacing(10)
			.listItemTint(.purple)
			.listRowSeparator(.hidden)
			.listStyle(.plain)
			#endif
		}
	}
}

#Preview {
	DestinationsView()
}

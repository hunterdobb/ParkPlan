//
//  ParkPlanApp.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/28/23.
//

import SwiftUI

@main
struct ParkPlanApp: App {
	@StateObject private var vm = DestinationsViewModel()

	// Disney Branch

    var body: some Scene {
        WindowGroup {
			TabView {
				DestinationsView()
					.environmentObject(vm)
					.tabItem {
						Image(systemName: "globe.americas.fill")
						Text("Destinations")
					}

				LiveDataTestView()
					.tabItem {
						Image(systemName: "gear")
						Text("Test")
					}
			}
        }
    }
}

//
//  ParkPlanApp.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/28/23.
//

import SwiftUI

@main
struct ParkPlanApp: App {
//	@StateObject var parkProvider = ParksProvider()
	@StateObject var scheduleService = DisneyDataService()

    var body: some Scene {
        WindowGroup {
			TabView {
				ParksView()
					.tabItem {
						Image(systemName: "square.grid.2x2.fill")
						Text("Browse")
					}

				TeView()
					.tabItem {
						Image(systemName: "gear")
						Text("Settings")
					}
			}
//			.environmentObject(parkProvider)
			.environmentObject(scheduleService)
        }
    }
}

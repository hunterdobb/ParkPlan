//
//  ParkPlanApp.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/28/23.
//

import SwiftUI

@main
struct ParkPlanApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
				DestinationsView()
                    .tabItem {
                        Image(systemName: "globe.americas.fill")
                        Text("Destinations")
                    }

//				#if os(iOS)
				Text("Settings")
					.tabItem {
						Image(systemName: "gear")
						Text("Test")
					}
//				#endif
            }
        }
    }
}

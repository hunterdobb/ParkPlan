//
//  InitialView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/13/23.
//

import SwiftUI

struct InitialView: View {
	@StateObject private var vm = DestinationsViewModel()

    var body: some View {
		TabView {
			DestinationsView()
				.environmentObject(vm)
				.tabItem {
					Image(systemName: "globe.americas.fill")
					Text("Destinations")
				}

			Text("Settings")
				.tabItem {
					Image(systemName: "gear")
					Text("Test")
				}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}

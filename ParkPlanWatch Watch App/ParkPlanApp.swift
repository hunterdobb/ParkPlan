//
//  InitialView.swift
//  ParkPlanWatch Watch App
//
//  Created by Hunter Dobbelmann on 2/10/23.
//

import SwiftUI

@main
struct ParkPlanApp: App {
	@StateObject private var vm = DestinationsViewModel()

	var body: some Scene {
		WindowGroup {
			DestinationsView()
				.environmentObject(vm)
		}
	}
}

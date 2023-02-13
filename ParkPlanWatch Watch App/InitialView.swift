//
//  InitialView.swift
//  ParkPlanWatch Watch App
//
//  Created by Hunter Dobbelmann on 2/10/23.
//

import SwiftUI

struct InitialView: View {
	@StateObject private var vm = DestinationsViewModel()

    var body: some View {
		DestinationsView()
			.environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}

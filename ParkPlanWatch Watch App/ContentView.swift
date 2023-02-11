//
//  ContentView.swift
//  ParkPlanWatch Watch App
//
//  Created by Hunter Dobbelmann on 2/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		List {
			ForEach(0..<10) { item in
				Text("Hello \(item)")
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

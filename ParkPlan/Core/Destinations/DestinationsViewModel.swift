//
//  DestinationsViewModel.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import OSLog
import SwiftUI

final class DestinationsViewModel: ObservableObject {
	@Published private(set) var parks = Bundle.main.decode("DisneyDestinations.json", as: DestinationEntry.self).parks
}

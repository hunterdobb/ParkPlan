//
//  Logger.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 7/21/23.
//

import OSLog

extension Logger {
	private static var subsystem = Bundle.main.bundleIdentifier!
	static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
	static let network = Logger(subsystem: subsystem, category: "network")
	static let statistics = Logger(subsystem: subsystem, category: "statistics")
}

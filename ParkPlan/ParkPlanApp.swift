//
//  ParkPlanApp.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/28/23.
//

import SwiftUI

class TestType: ObservableObject {
	@Published var hi = "Hi"
}

struct TestTypeKey: EnvironmentKey {
	static var defaultValue = TestType()
}

extension EnvironmentValues {
	var testType: TestType {
		get { self[TestTypeKey.self] }
		set { self[TestTypeKey.self] = newValue }
	}
}

@main
struct ParkPlanApp: App {
	@State var testType = TestType()
	@StateObject var dataFetcher = DataFetcher()

    var body: some Scene {
        WindowGroup {
            InitialView()
				.environment(\.testType, testType)
				.environmentObject(dataFetcher)

//			LiveDataTestView()
        }
    }
}

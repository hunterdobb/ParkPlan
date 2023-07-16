//
//  DiningView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 7/15/23.
//

import SwiftUI

struct DiningView: View {
	let id: String

	@State private var liveData: EntityLiveData?

    var body: some View {
		if let liveData, let diningAvailability = liveData.diningAvailability {
			List {
				ForEach(diningAvailability, id: \.self) { dining in
					HStack {
						Text("Party of \(dining.partySize)")
						Text("waits \(dining.waitTime) minutes")
					}
				}
			}
		}
		Text("\(liveData?.diningAvailability?.first?.waitTime ?? 12)")
			.task {
				liveData = try? await NetworkingManager.shared.request(.live(id: id), type: EntityLiveDataResponse.self).liveData?.first ?? nil
			}
    }

}

#Preview {
	DiningView(id: "libertytreetavern")
}

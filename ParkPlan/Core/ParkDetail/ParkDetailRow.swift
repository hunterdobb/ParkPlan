//
//  ParkDetailRow.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/6/23.
//

import SwiftUI

struct ParkDetailRow: View {
	let name: String
	let liveData: String
	let color: Color

    var body: some View {
        HStack {
			Text(name)
			Spacer()
			waitTime
        }
    }
}

struct ParkDataRow_Previews: PreviewProvider {
    static var previews: some View {
		ParkDetailRow(name: "Hagrids", liveData: "80", color: .pink)
			.padding()
    }
}

private extension ParkDetailRow {
	var waitTime: some View {
		Text(liveData)
			.foregroundColor(.white)
			.font(.headline)
			.padding(.horizontal)
			.padding(.vertical, 8)
			.background(color, in: RoundedRectangle(cornerRadius: 5))
	}
}

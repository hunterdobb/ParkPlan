//
//  ParkDataRow.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/6/23.
//

import SwiftUI

struct ParkDataRow: View {
	let itemId: String
	let name: String

    var body: some View {
        HStack {
			Text(name).font(.headline)
			Spacer()
			waitTime
        }
    }
}

struct ParkDataRow_Previews: PreviewProvider {
    static var previews: some View {
        ParkDataRow(itemId: "1", name: "Hagrid's Motorbike")
			.padding()
    }
}

private extension ParkDataRow {
	var waitTime: some View {
		Text("80")
			.foregroundColor(.white)
			.font(.headline)
			.padding(.horizontal)
			.padding(.vertical, 8)
			.background(.pink.gradient, in: RoundedRectangle(cornerRadius: 5))
	}
}

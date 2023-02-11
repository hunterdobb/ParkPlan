//
//  POICardView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import SwiftUI

/*

struct POICardView: View {
    var body: some View {
		NavigationStack {
			ScrollView() {
				scroll.padding([.top, .bottom])
				scroll.padding(.bottom)
				scroll.padding(.bottom)
				scroll
			}
//			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle("Islands of Adventure")
		}
    }
}

struct POICardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
        	POICardView()
        }
    }
}

private extension POICardView {
	var scroll: some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .center, spacing: 5) {
				Text("Favorites")
				Image(systemName: "chevron.forward")
					.font(.system(.headline, weight: .bold))
					.foregroundColor(.primary.opacity(0.45))
			}
			.padding(.leading, 20)
			.font(.system(.title2, design: .rounded, weight: .bold))

			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					POICard(name: "The High in the Sky Seuss Trolley Train Ride!™", wait: "5 min wait", color: .green)
					POICard(name: "Hagrid's Magical Creatures Motorbike Adventure™", wait: "100 min wait", color: .pink)
					POICard(name: "Jurassic World VelociCoaster", wait: "50 min wait", color: .orange)
					POICard(name: "Hog's Head™", wait: "Open", color: .green)
				}
				.padding(.horizontal)
			}
		}
	}
}

struct POICard: View {
	let name: String
	let wait: String
	let color: Color

	var body: some View {
		VStack(alignment: .leading) {
			Text(name)
				.foregroundStyle(color.shadow(.inner(radius: 10)))
				.lineLimit(3)
				.frame(maxWidth: .infinity, alignment: .leading)
				.frame(maxHeight: .infinity, alignment: .top)
				.font(.largeTitle)
				.bold()
				.minimumScaleFactor(0.5)
				.padding(.top, 1)

			Text(wait)
				.foregroundColor(.white)
				.font(.headline)
				.padding(.horizontal)
				.padding(.vertical, 8)
				.background(color.gradient, in: RoundedRectangle(cornerRadius: 10))
		}
		.dynamicTypeSize(.medium)
		.frame(width: 200, height: 110)
		.padding(12)

		.background(color.gradient.opacity(0.2), in: RoundedRectangle(cornerRadius: 15))
	}
}

*/

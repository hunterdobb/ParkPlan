//
//  ParkBannerView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/1/23.
//

import SwiftUI

struct ParkBannerView: View {
	let park: Park

	/// Tuple value representing color and saturation amount
	/// color.0 is color
	/// color.1 is saturation
	var color: (Color, Double) {
		switch park.name {
		case ParkNames.magicKingdom.rawValue: (Color.blue, 0.5)
		case ParkNames.epcot.rawValue: (Color.indigo, 0.8)
		case ParkNames.hollywoodStudios.rawValue: (Color.orange, 0.4)
		case ParkNames.animalKingdom.rawValue: (Color.green, 0.5)
		default: (Color.blue, 0.5)
		}
	}

	var operatingHours: String? {
		guard let entries = park.schedule else { return nil }

		if let operating = entries.first(where: { $0.type == .operating }) {
			let open = operating.openingTime
			let close = operating.closingTime
			return "\(open.formatted(date: .omitted, time: .shortened)) - \(close.formatted(date: .omitted, time: .shortened))"
		} else {
			return nil
		}
	}

	var body: some View {
		Image(park.bannerImageName)
			.resizable()
			.scaledToFit()
			.overlay(
				ZStack(alignment: .bottom) {
					Image(park.bannerImageName)
						.resizable()
						.blur(radius: 15) /// blur the image
						.padding(-20) /// expand the blur a bit to cover the edges
						.clipped() /// prevent blur overflow
						.mask(blurGradient) /// mask the blurred image using the gradient's alpha values

					colorGradient(color.0).saturation(color.1) /// also add the gradient as an overlay (this time, the purple will show up)

					HStack {
						VStack(alignment: .leading) {
							Text(park.name)
								.font(.system(.title, design: .rounded, weight: .heavy))
							if let operatingHours {
								Text(operatingHours)
									.font(.system(.headline, design: .rounded, weight: .bold))
									.opacity(0.9)
							} else {
								Text("0:00 AM - 0:00 PM")
									.font(.system(.headline, design: .rounded, weight: .bold))
									.opacity(0)
									.background(
										.secondary.opacity(0.2),
										in: .rect(cornerRadius: 3, style: .continuous)
									)
							}
						}
						.frame(maxWidth: .infinity, alignment: .leading) /// allow text to expand horizontally
					}
					.foregroundColor(.white)
					.padding(20)
				}
			)
			.clipShape(.rect(cornerRadius: 20, style: .continuous))
	}

	/// Used for color gradient
	func colorGradient(_ color: Color) -> LinearGradient {
		LinearGradient(
			gradient: Gradient(
				stops: [
					.init(color: color, location: 0),
					.init(color: .clear, location: 0.5)
				]
			),
			startPoint: .bottom,
			endPoint: .top
		)
	}

	/// Used as alpha mask for blur gradient
	let blurGradient = LinearGradient(
		gradient: Gradient(
			stops: [
				.init(color: .black, location: 0.15),
				.init(color: .clear, location: 0.5)
			]
		),
		startPoint: .bottom,
		endPoint: .top
	)
}

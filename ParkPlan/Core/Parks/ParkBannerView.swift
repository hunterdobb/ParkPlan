//
//  ParkBannerView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/1/23.
//

import SwiftUI

struct ParkBannerView: View {
	let park: Park

	@EnvironmentObject var disneyDataService: DisneyDataService

	/// Tuple value representing color and saturation amount
	var colorData: (color: Color, saturation: Double) {
		switch park.name {
		case .magicKingdom: (Color.blue, 0.5)
		case .epcot: (Color.indigo, 0.8)
		case .hollywoodStudios: (Color.orange, 0.4)
		case .animalKingdom: (Color.green, 0.5)
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

					colorGradient(colorData.color)
						.saturation(colorData.saturation) /// also add the gradient as an overlay (this time, the purple will show up)

					HStack {
						VStack(alignment: .leading) {
							Text(park.parkName)
								.font(.system(.title, design: .rounded, weight: .heavy))
							if let operatingHours = disneyDataService.getOperatingHours(for: park) {
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

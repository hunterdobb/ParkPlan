//
//  DestinationsView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct ParkBannerDetails {
	let parkName: String
	let image: Image
	let imageOffset: CGSize
	let imageScale: CGFloat
	let color: Color
	let colorSaturation: Double

	static var details = [
		ParkBannerDetails(
			parkName: "Magic Kingdom",
			image: Image("MagicKingdomBanner"),
			imageOffset: CGSize(width: 0, height: -50),
			imageScale: 1.5,
			color: .blue,
			colorSaturation: 0.5
		),
		ParkBannerDetails(
			parkName: "EPCOT",
			image: Image("EpcotBanner"),
			imageOffset: CGSize(width: 0, height: 0),
			imageScale: 1,
			color: .indigo,
			colorSaturation: 0.8
		),
		ParkBannerDetails(
			parkName: "Hollywood Studios",
			image: Image("HollywoodStudiosBanner"),
			imageOffset: CGSize(width: 0, height: -5),
			imageScale: 1.2,
			color: .orange,
			colorSaturation: 0.4
		),
		ParkBannerDetails(
			parkName: "Animal Kingdom",
			image: Image("AnimalKingdomBanner"),
			imageOffset: CGSize(width: 0, height: -45),
			imageScale: 1.5,
			color: .green,
			colorSaturation: 0.5
		)
	]


	static var magicKingdom = ParkBannerDetails(
		parkName: "Magic Kingdom",
		image: Image("MagicKingdomBanner"),
		imageOffset: CGSize(width: 0, height: -50),
		imageScale: 1.5,
		color: .blue,
		colorSaturation: 0.5
	)
	/*
	static var epcot = ParkBannerDetails(
		parkName: "EPCOT",
		image: Image("EpcotBanner"),
		imageOffset: CGSize(width: 0, height: 0),
		imageScale: 1,
		color: .indigo,
		colorSaturation: 0.8
	)
	static var hollywoodStudios = ParkBannerDetails(
		parkName: "Hollywood Studios",
		image: Image("HollywoodStudiosBanner"),
		imageOffset: CGSize(width: 0, height: -5),
		imageScale: 1.2,
		color: .indigo,
		colorSaturation: 0.4
	)
	static var animalKingdom = ParkBannerDetails(
		parkName: "Animal Kingdom",
		image: Image("AnimalKingdomBanner"),
		imageOffset: CGSize(width: 0, height: -45),
		imageScale: 1.5,
		color: .green,
		colorSaturation: 0.5
	)
	 */
}

struct ParkBanner: View {
	let park: DestinationParkEntry
	let bannerDetails: ParkBannerDetails

	var body: some View {
		bannerDetails.image
			.resizable()
			.scaledToFit()
			.scaleEffect(bannerDetails.imageScale)
			.offset(bannerDetails.imageOffset)
			.overlay(
				ZStack(alignment: .bottom) {
					bannerDetails.image
						.resizable()
						.scaleEffect(bannerDetails.imageScale)
						.offset(bannerDetails.imageOffset)
						.blur(radius: 15) /// blur the image
						.padding(-20) /// expand the blur a bit to cover the edges
						.clipped() /// prevent blur overflow
						.mask(blurGradient) /// mask the blurred image using the gradient's alpha values

					colorGradient(bannerDetails.color).saturation(bannerDetails.colorSaturation) /// also add the gradient as an overlay (this time, the purple will show up)

					HStack {
						VStack(alignment: .leading) {
							Text(park.name)
								.font(.system(.title, design: .rounded, weight: .heavy))
							Text("9:00 AM - 10:00 PM")
								.font(.system(.headline, design: .rounded, weight: .bold))
								.opacity(0.9)
						}
						.frame(maxWidth: .infinity, alignment: .leading) /// allow text to expand horizontally
					}
					.foregroundColor(.white)
					.padding(20)
				}
			)
			.clipShape(.rect(cornerRadius: 20, style: .continuous))
			#if !os(watchOS)
			.listRowSeparator(.hidden)
			#endif
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

struct DestinationsView: View {
	let parks = Bundle.main.decode("DisneyDestinations.json", as: DestinationEntry.self).parks
	@Environment(\.colorScheme) var colorScheme

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

	var body: some View {
		NavigationStack {
			List {
				ForEach(parks) { park in
					ParkBanner(
						park: park,
						bannerDetails: .details.first { $0.parkName == park.name } ?? .magicKingdom
					)
				}

				ForEach(parks, content: ParkRowView.init)
					.listRowInsets(.init(top: 15, leading: 30, bottom: 15, trailing: 30))
			}
			.navigationTitle("Disney World")
			#if !os(watchOS)
			.listRowSpacing(-10)
			.listItemTint(.purple)
			.listRowSeparator(.hidden)
			.listStyle(.plain)
			#endif
		}
	}
}

#Preview {
	DestinationsView()
}

// MARK: - Old Code
/*
 Image("AnimalKingdomBanner")
	 .resizable()
	 .scaledToFit()
	 .scaleEffect(1.5)
	 .offset(y: -35)
	 .overlay(alignment: .bottom) {
		 HStack {
			 VStack(alignment: .leading, spacing: 0) {
				 Text("Animal Kingdom")
					 .font(.system(.title, design: .rounded, weight: .heavy))

				 Text("9:00 AM - 7:00 PM")
					 .font(.system(.headline, design: .rounded, weight: .bold))
			 }
			 .foregroundStyle(.white)
			 Spacer()
//							Image(systemName: "chevron.forward")
//								.font(.system(.headline, design: .rounded, weight: .heavy))
//								.foregroundStyle(.white.opacity(0.5))
		 }
		 .padding([.leading, .trailing, .bottom])
		 .padding([.top], 10)
		 #if !os(watchOS)
		 .background(.ultraThinMaterial)
		 #endif
		 .background(.green.opacity(0.5))
	 }
	 .clipShape(.rect(cornerRadius: 20, style: .continuous))
 */

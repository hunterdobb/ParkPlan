//
//  ParksView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct ParksView: View {
	@EnvironmentObject var disneyDataService: DisneyDataService

	@State private var selectedPark: Park?

	var body: some View {
		NavigationStack {
			ScrollView {
				ForEach(disneyDataService.parks) { park in
					NavigationLink(value: park) {
						ParkBannerView(park: park)
							.padding(.horizontal)
					}
					.buttonStyle(.animated)
				}
			}
			.navigationTitle(disneyDataService.resort.name)
			.navigationDestination(for: Park.self) { park in
				#if os(iOS)
				EntitiesListView(park: park)
//					ParkOverviewView()
//						.environmentObject(ParkOverviewViewModel(park: park))
				#elseif os(watchOS)
//					ParkDetailView(park: park, entityType: .attraction)
				EntitiesListView(park: park)
				#endif
			}
		}
	}

	/*
	var body: some View {
		NavigationStack {
			ScrollView {
				ForEach(disneyDataService.parks) { park in
					NavigationLink {
						#if os(iOS)
						EntitiesListView(park: park)
//						ParkOverviewView()
//							.environmentObject(ParkOverviewViewModel(park: park))
						#elseif os(watchOS)
//						ParkDetailView(park: park, entityType: .attraction)
						EntitiesListView(park: park)
						#endif
					} label: {
						ParkBannerView(park: park)
							.padding(.horizontal)
					}
					.buttonStyle(.animated)
				}
			}
			.navigationTitle(disneyDataService.resort.name)
		}
	}
	 */
}

#Preview {
	ParksView()
		.environmentObject(DisneyDataService())
}

struct AnimatedButton: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
			.saturation(configuration.isPressed ? 1.4 : 1)
			.animation(.easeOut(duration: 0.2), value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == AnimatedButton {
	static var animated: AnimatedButton { .init() }
}

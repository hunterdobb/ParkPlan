//
//  EntityDetailView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//

import MapKit
import OSLog
import SwiftUI

struct EntityDetailView: View {
	let entity: Entity

	@EnvironmentObject var disneyDataService: DisneyDataService
	@Environment(\.colorScheme) var colorScheme

	@State private var barHidden = true
	@State private var headerHeight = CGFloat.zero

	let contentColor = Color.blue.opacity(0.1)

	@State private var expandDescription = false

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 10) {
				VStack(alignment: .leading, spacing: 0) {
					entityNameHeader
					entityInfoSubHeader
				}
				.padding(.leading, 12)

				description

				Grid {
					GridRow {
						VStack(alignment: .leading) {
							Label("WAIT", systemImage: "timer")
								.frame(maxWidth: .infinity, alignment: .leading)
								.foregroundStyle(.blue.opacity(0.5))
								.font(.system(.footnote, design: .rounded, weight: .semibold))
								.padding(.leading, 4)

							Spacer()

							Text("\(disneyDataService.getStandbyValue(for: entity) ?? 0) min")
								.foregroundStyle(.blue)
								.saturation(0.5)
								.font(.system(.largeTitle, design: .rounded, weight: .bold))

							Spacer()

							if let updated = disneyDataService.getUpdateTime(for: entity) {
								Text("As of: \(Text(updated, style: .time))")
									.font(.caption)
									.foregroundStyle(.gray.opacity(0.8))
							}
						}
						.frame(maxHeight: .infinity)
						.padding(13)
						.background(contentColor, in: .rect(cornerRadius: 15, style: .continuous))

						VStack(alignment: .leading) {
							Label("LOCATION", systemImage: "timer")
								.frame(maxWidth: .infinity, alignment: .leading)
								.foregroundStyle(.blue.opacity(0.5))
								.font(.system(.footnote, design: .rounded, weight: .semibold))
								.padding(.leading, 4)

							Text("65 min")
								.foregroundStyle(.blue)
								.saturation(0.5)
								.font(.system(.largeTitle, design: .rounded, weight: .bold))
						}
						.frame(maxHeight: .infinity)
						.padding(13)
						.background(contentColor, in: .rect(cornerRadius: 15, style: .continuous))
					}
					.fixedSize(horizontal: false, vertical: true)
				}

				VStack(alignment: .leading) {
					Label("LOCATION", systemImage: "map.fill")
						.foregroundStyle(.blue.opacity(0.5))
						.font(.system(.footnote, design: .rounded, weight: .semibold))
						.padding(.leading, 4)
					map
				}
				.padding(13)
				.background(contentColor, in: .rect(cornerRadius: 15, style: .continuous))

			}
			.animation(.bouncy, value: expandDescription)
			.padding(.horizontal)
			.background {
				GeometryReader {
					Color.clear.preference(
						key: ViewOffsetKey.self,
						value: -$0.frame(in: .named("scroll")).origin.y
					)
				}
			}
			.onPreferenceChange(ViewOffsetKey.self) {
				if !barHidden && $0 < (headerHeight / 1.5) {
					barHidden = true
				} else if barHidden && $0 > (headerHeight / 1.5) {
					barHidden = false
				}
			}
			.onPreferenceChange(ViewHeightKey.self) {
				headerHeight = $0
			}
		}
		.coordinateSpace(name: "scroll")
		.navigationBarTitleDisplayMode(.inline)
		#if !os(watchOS)
		.toolbar {
			ToolbarItem(placement: .principal) {
				Text(entity.shortName ?? entity.name)
					.lineLimit(1)
					.minimumScaleFactor(0.8)
					.opacity(barHidden ? 0 : 1)
					.font(.system(.headline, design: .rounded, weight: .bold))
			}

			ToolbarItem(placement: .primaryAction) {
				Menu {
					Button {
						Task {
							await disneyDataService.fetchLiveData()
						}
					} label: {
						Label("Refresh", systemImage: "arrow.clockwise")
					}

				} label: {
					Image(systemName: "ellipsis.circle")
				}
			}
		}
		#endif
		.animation(.easeInOut(duration: 0.3), value: barHidden)
	}
}

#Preview {
	NavigationStack {
		EntityDetailView(entity: .example)
			.environmentObject(DisneyDataService())
	}
}

extension EntityDetailView {
	private var entityNameHeader: some View {
		Text(entity.name)
			.opacity(barHidden ? 1 : 0)
			.frame(maxWidth: .infinity, alignment: .leading)
			.font(.system(.title2, design: .rounded, weight: .heavy))
			.coordinateSpace(name: "header")
			.background {
				GeometryReader {
					Color.clear.preference(
						key: ViewHeightKey.self,
						value: $0.frame(in: .named("header")).height
					)
				}
			}
	}

	private var entityInfoSubHeader: some View {
		HStack(spacing: 0) {
			Text("\(entity.entityType.rawValue.capitalized) • \(entity.land.rawValue)")
		}
		.foregroundStyle(.gray)
	}

	private var description: some View {
		VStack(alignment: .leading) {
			Label("ABOUT", systemImage: "book.pages.fill")
				.foregroundStyle(.blue.opacity(0.5))
				.font(.system(.footnote, design: .rounded, weight: .semibold))
				.padding(.bottom, 2)
			Text(entity.description)
				.animation(nil, value: expandDescription)
				.lineLimit(expandDescription ? nil : 3)
				.font(.callout)
				.frame(maxWidth: .infinity, alignment: .leading)

			Text(expandDescription ? "Show less" : "Show more")
				.animation(nil, value: expandDescription)
				.font(.caption)
				.bold()
				.offset(y: 3)
				.foregroundColor(.blue)
		}
		.padding([.leading, .trailing, .bottom])
		.padding(.top, 11)
		.background(contentColor, in: .rect(cornerRadius: 15, style: .continuous))
		.onTapGesture {
			expandDescription.toggle()
		}
	}

	private var map: some View {
		Map(coordinateRegion: .constant(MKCoordinateRegion(
			center: CLLocationCoordinate2D(
				latitude: entity.latitude,
				longitude: entity.longitude),
			span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
		)), annotationItems: [entity]
		) {
			MapMarker(
				coordinate: CLLocationCoordinate2D(
					latitude: $0.latitude,
					longitude: $0.longitude
				),
				tint: .teal
			)
		}
		.aspectRatio(1.5, contentMode: .fit)
		.clipShape(.rect(cornerRadius: 6, style: .continuous))
		.allowsHitTesting(false)
	}
}

struct ViewOffsetKey: PreferenceKey {
	typealias Value = CGFloat
	static var defaultValue = CGFloat.zero
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value += nextValue()
	}
}

struct ViewHeightKey: PreferenceKey {
	typealias Value = CGFloat
	static var defaultValue = CGFloat.zero
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value += nextValue()
	}
}

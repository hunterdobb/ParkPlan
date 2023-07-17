//
//  ItemDetailView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 7/16/23.
//

import SwiftUI

struct ItemDetailView: View {
	let name: String
	let id: String
	let liveData: EntityLiveData?

	@State private var extraInfo: EntityData?

	var standbyWait: String? {
		if let standby = liveData?.queue?.standby?.waitTime {
			return "\(standby) minutes"
		} else {
			return nil
		}
	}

	var returnStart: String? {
		if liveData?.queue?.returnTime?.state == .available {
			if let start = liveData?.queue?.returnTime?.returnStart {
				return start.formatted(date: .omitted, time: .shortened)
			} else {
				return nil
			}
		} else {
			return nil
		}
	}

	var operatingHours: String? {
		if let normal = liveData?.operatingHours?.first(where: { ($0.type ?? "") == OperatingHoursType.operating.rawValue }) {
			if let start = normal.startTime, let end = normal.endTime {
				return "\(start.formatted(date: .omitted, time: .shortened)) - \(end.formatted(date: .omitted, time: .shortened))"
			} else {
				return nil
			}
		} else {
			return nil
		}
	}

	var earlyHours: String? {
		if let early = liveData?.operatingHours?.first(where: { ($0.type ?? "") == OperatingHoursType.earlyEntry.rawValue }) {
			if let start = early.startTime, let end = early.endTime {
				return "\(start.formatted(date: .omitted, time: .shortened)) - \(end.formatted(date: .omitted, time: .shortened))"
			} else {
				return nil
			}
		} else {
			return nil
		}
	}

	var cuisines: [String] {
		if let cuisines = extraInfo?.cuisines {
			return cuisines
		} else {
			return ["Not Available"]
		}
	}

	var showtimeList: String? {
		if let showtimes = liveData?.showtimes {
			let list = showtimes.compactMap { showtime -> String? in
				if let start = showtime.startTime, let end = showtime.endTime {
					if start == end {
						return start.formatted(date: .omitted, time: .shortened)
					} else {
						return nil
					}
				} else {
					return nil
				}
			}
			return list.joined(separator: ", ")
		} else {
			return nil
		}
	}

    var body: some View {
		List {
			Text(name).font(.largeTitle)
				.listRowBackground(Color.clear)
				.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

			if let operatingHours {
				Section {
					LabeledContent("Hours", value: operatingHours)

					if let earlyHours {
						LabeledContent("Early Entry", value: earlyHours)
					}
				}
			}

			if let forecast = liveData?.forecast {
				Section {
					ForecastTestView(forecast: forecast, currentWait: liveData?.queue?.standby?.waitTime)
						.listRowBackground(
							RoundedRectangle(cornerRadius: 20, style: .continuous)
								.foregroundStyle(.purple.gradient.opacity(0.3))
						)
				}
			}

			// MARK: Show Data
			if liveData?.entityType == .show {
				if let showtimes = liveData?.showtimes, showtimes.isEmpty == false {
					Section {
						if let start = showtimes.first?.startTime, let end = showtimes.first?.endTime {
							if start != end {
								ForEach(showtimes, id: \.self) { showtime in
									HStack {
										Text(start, style: .time)
										Text("-")
										Text(end, style: .time)
									}
								}
							} else {
								if let showtimeList {
									Text(showtimeList)
								}
							}
						}
					} header: {
						Text("Show Times")
							.textCase(nil)
							.foregroundStyle(.purple)
							.font(.system(.title, design: .rounded, weight: .bold))
//							.frame(maxWidth: .infinity, alignment: .center)
					}
				}
			}

			if let standbyWait {
				Section {
					LabeledContent("Standby", value: standbyWait)
				} header: {
					Text("Wait Times")
						.textCase(nil)
						.font(.headline)
				}
			}

			if let returnStart {
				Section("Return Time") {
					Text(returnStart)
				}
			}

			// MARK: Restaurant Data
			if liveData?.entityType == .restaurant {
				if let diningAvailability = liveData?.diningAvailability {
					Section("Wait per Party Size") {
						ForEach(diningAvailability, id: \.self) { dine in
							Text("Party of \(dine.partySize) waits \(dine.waitTime) minutes")
						}
					}
				}

				if let cuisines = extraInfo?.cuisines {
					if cuisines.isEmpty == false {
						Section("Cuisines") {
							Text(cuisines.joined(separator: ", "))
						}
					}
				}
			}


		}
		.navigationTitle(name)
		.navigationBarTitleDisplayMode(.inline)
		.task {
			do {
				extraInfo = try await NetworkingManager.shared.request(.entity(id: id), type: EntityData.self)
			} catch {
				print(error)
			}

		}
	}
}

#Preview("Restaurant") {
	NavigationStack {
		ItemDetailView(
			name: "Be Our Guest Restaurant",
			id: "beourguestrestaurant",
			liveData: .restaurantPreview
		)
	}
}

#Preview("Attraction") {
	NavigationStack {
		ItemDetailView(
			name: "Space Mountain",
			id: "spacemountain",
			liveData: .attractionPreview
		)
	}
}

#Preview("Show") {
	NavigationStack {
		ItemDetailView(
			name: "Meet Mickey at Town Square Theater",
			id: "a2d92647-634d-4eb4-886b-9da858e871f1", // no slug available
			liveData: .showPreview
		)
	}
}

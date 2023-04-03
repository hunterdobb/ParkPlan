//
//  LiveDataTestView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/15/23.
//

import Charts
import SwiftUI

struct ForecastTestView: View {
	let forecast: [Forecast]
	let currentWait: Int?

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text("Forecast")
				.lineLimit(3)
				.font(.headline)
				.padding(.top)
			Text("subject to change").font(.caption)

			Chart {
				ForEach(forecast, id: \.self) { data in
					BarMark(
						x: .value("Time", data.time, unit: .hour),
						y: .value("Wait", data.percentage)
					)
					.annotation(position: .top, alignment: .center, spacing: 0) {
						if Calendar.current.isDate(.now, equalTo: data.time, toGranularity: .hour) {
							if let currentWait {
								Text("\(currentWait)m")
									.font(.system(.body, weight: .heavy))
							}
						}
					}
					.foregroundStyle(
						Calendar.current.isDate(.now, equalTo: data.time, toGranularity: .hour) ? .purple :
							(Date.now...).contains(data.time) ? .purple.opacity(0.7) : .purple.opacity(0.3)
					)
					.cornerRadius(2)
				}
			}
			.chartYAxis(.hidden)
			.chartYScale(domain: 0...100) // Using percentage
			.frame(height: 75)
			.padding(.top, 8)
		}
	}
}

struct ShowtimesTestView: View {
	let showtimes: [LiveShowTime]

	var body: some View {
		ForEach(showtimes, id: \.self) { showtime in
			Text(showtime.startTime ?? .now, style: .time)
		}
	}
}

struct LiveDataTestView: View {
	@State private var liveDataResponse: EntityLiveDataResponse?
	@State private var isLoading = false
	@State private var hasError = false
	@State private var error: NetworkingManager.NetworkingError?
	@State private var imageName = "star"
	@State private var searchText = ""

	func results(response: EntityLiveDataResponse) -> [EntityLiveData] {
		if searchText.isEmpty {
			return liveDataResponse?.liveData ?? [EntityLiveData]()
		}

		return liveDataResponse?.liveData?.filter { $0.name.contains(searchText) } ?? [EntityLiveData]()
	}

    var body: some View {
		NavigationStack {
			if let liveDataResponse {
				List {
					ForEach(results(response: liveDataResponse)) { liveData in
						VStack(alignment: .leading, spacing: 0) {
							HStack(alignment: .top) {
								getImage(type: liveData.entityType)
									.foregroundStyle(.indigo.gradient)
								VStack(alignment: .leading, spacing: 0) {
									HStack(alignment: .center) {
										Text(liveData.name)
											.font(.system(.title3, weight: .heavy))
									}
									.font(.system(.body, design: .default, weight: .bold))

									HStack(alignment: .firstTextBaseline, spacing: .zero) {
										if (liveData.queue?.standby?.waitTime) != nil {
//											if let standbyWaitTime = liveData.queue?.standby?.waitTime
		//									Text(" • ").font(.system(.body, weight: .black))
		//									Image(systemName: "timer")
		//										.font(.system(.body, design: .default, weight: .bold))
		//										.foregroundStyle(.indigo)
		//									Text("\(standbyWaitTime)m")
		//										.font(.system(.body, weight: .bold))
		//										.foregroundStyle(.indigo)
										} else {
		//									Text(" • ").font(.system(.body, weight: .black))
											Text(liveData.status?.rawValue.capitalized ?? "")
												.font(.system(.body, weight: .bold))
												.foregroundStyle(.indigo)
										}

										Spacer()
									}
									.font(.caption)

									if let returnTime = liveData.queue?.returnTime {
										Text("Return: \(returnTime.returnStart ?? .now, style: .time)")
											.font(.caption)
									}
								}
							}

							if let showtimes = liveData.showTimes {
								ShowtimesTestView(showtimes: showtimes)
							}

							if let forecast = liveData.forecast {
								ForecastTestView(forecast: forecast, currentWait: liveData.queue?.standby?.waitTime)
							}
						}
						#if !os(watchOS)
						.padding(.vertical, 8)
						.padding(.horizontal, 12)
						.listRowSeparator(.hidden)
						.listRowBackground(
							RoundedRectangle(cornerRadius: 20)
								.padding(.horizontal)
								.padding(.vertical, 5)
								.foregroundStyle(.purple.gradient.opacity(0.3))
//								.shadow(color: .purple, radius: 8, x: 0, y: 0)
						)

						#else
						.listItemTint(.purple.opacity(0.3))
						#endif


					}
				}
				.searchable(text: $searchText)
				.listStyle(.plain)
				.navigationTitle(liveDataResponse.name)
			} else {
				ProgressView()
			}
		}
		.task {
			await fetchLiveData(for: "magickingdompark")
		}
    }

	func getImage(type: EntityType) -> Image {
		switch type {
		case .attraction:
			return Image(systemName: "star.fill")
		case .show:
			return Image(systemName: "theatermasks.fill")
		case .restaurant:
			return Image(systemName: "fork.knife")
		default:
			return Image(systemName: "star.fill")
		}
	}

	@MainActor
	func fetchLiveData(for id: String) async {
		isLoading = true
		defer { isLoading = false }

		do {
			let response = try await NetworkingManager.shared.request(.live(id: id), type: EntityLiveDataResponse.self)
			liveDataResponse = response
		} catch {
			hasError = true

			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
	}
}

struct LiveDataTestView_Previews: PreviewProvider {
    static var previews: some View {
        LiveDataTestView()
    }
}

private extension LiveDataTestView {

}

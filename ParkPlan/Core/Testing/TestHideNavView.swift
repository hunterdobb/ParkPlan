//
//  TestHideNavView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//


import SwiftUI

struct TeView: View {
	var body: some View {
		NavigationStack {
			NavigationLink("Next") {
				TestShowNavBarWhenScrolling()
					.toolbarRole(.editor) /// Removes "Back" text on next screen
			}
		}
	}
}

struct TestShowNavBarWhenScrolling: View {
	@State private var barHidden = true

	var body: some View {
		ScrollView {
			VStack {
				VStack(alignment: .leading) {
						Text("Space Mountain: Long Title Test")
							.opacity(barHidden ? 1 : 0)
							.frame(maxWidth: .infinity, alignment: .leading)
							.font(.system(.largeTitle, design: .rounded, weight: .heavy))

						Text("Tomorrowland • Magic Kingdom")
							.transition(.move(edge: .top))
							.font(.body)
							.foregroundStyle(.secondary)
				}
				.padding(.horizontal)

				ForEach(0 ..< 3) { _ in
					Image(systemName: "rectangle.fill")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.padding()
				}
			}
			.background {
				GeometryReader {
					Color.clear.preference(
						key: ViewOffsetKey.self,
						value: -$0.frame(in: .named("scroll")).origin.y
					)
				}
			}
			.onPreferenceChange(ViewOffsetKey.self) {
				if !barHidden && $0 < 50 {
					barHidden = true
				} else if barHidden && $0 > 50 {
					barHidden = false
				}
			}
		}
		.coordinateSpace(name: "scroll")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .principal) {
				Text("Space Mountain")
					.opacity(barHidden ? 0 : 1)
					.font(.system(.headline, design: .rounded, weight: .bold))
			}
		}
		.animation(.default, value: barHidden)
	}
}

struct TestShowNavBarWhenScrolling_Previews: PreviewProvider {
	static var previews: some View {
		TeView()
	}
}

struct ViewOffsetKey: PreferenceKey {
	typealias Value = CGFloat
	static var defaultValue = CGFloat.zero
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value += nextValue()
	}
}

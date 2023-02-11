//
//  LiveDataTagView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/9/23.
//

import SwiftUI

struct LiveDataTagView: View {
	let text: String
	let color: Color

    var body: some View {
		Text(text)
			.foregroundColor(.white)
			.font(.system(.headline, design: .rounded, weight: .heavy))
//			.font(.headline)
			.padding(.horizontal)
			.padding(.vertical, 8)
			.background(color.gradient, in: RoundedRectangle(cornerRadius: 10))
    }
}

struct LiveDataTagView_Previews: PreviewProvider {
    static var previews: some View {
		LiveDataTagView(text: "30 min wait", color: .orange)
			.padding()
			.previewLayout(.sizeThatFits)
    }
}

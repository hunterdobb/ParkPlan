//
//  TestView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/5/23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
		Text(Date() - 66, format: .relative(presentation: .named, unitsStyle: .wide))

//		let tmp: Date.RelativeFormatStyle.Presentation
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

//
//  EntityDetailView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//

import SwiftUI

struct EntityDetailView: View {
	let entity: Entity

    var body: some View {
		Text(entity.name)
    }
}

//#Preview {
//    EntityDetailView()
//}

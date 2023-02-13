//
//  RideWaitRow.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/1/23.
//

import SwiftUI

struct RideWaitRow: View {
    let ride: EntityLiveData

    var body: some View {
        HStack {
            Text(ride.name)
                .font(.headline)

            Spacer()

            let wait = ride.queue?.standby?.waitTime
            if ride.status == .operating {
                if let wait {
                    Text("\(wait)")
                        .foregroundColor(wait < 30 ? .green : wait > 60 ? .red : .orange)
                } else {
                    Text("Open")
                        .foregroundColor(.green)
                }
            } else {
                Text(ride.status?.rawValue.capitalized ?? "Unknown")
                    .foregroundStyle(.pink.gradient)
            }
        }
    }
}

struct RideWaitRow_Previews: PreviewProvider {
    static var previewRide: EntityLiveData {
       let rides = try! StaticJSONMapper.decode(file: "UniversalIOALiveResponse",
                                            type: EntityLiveDataResponse.self)
        return rides.liveData!.first!
    }

    static var previews: some View {
        RideWaitRow(ride: previewRide)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

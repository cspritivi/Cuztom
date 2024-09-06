//
//  MeasurementView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/28/24.
//

import SwiftUI

struct MeasurementView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        
        if let user = authViewModel.currentUser {
            let measurements: [CMeasurement] = [
                CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 1"),
                CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 2"),
                CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 3"),
                CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 4"),
                CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 5"),
                CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 6"),
                CMeasurement(customer: authViewModel.currentUser!, forSelf: true, measurementFor: user.fullName, notes: "Hello World 7")
            ]
            List {
                ForEach(measurements, id: \.notes) { measurement in
                    NavigationLink(value: measurement) {
                        Text(measurement.notes)
                    }
                }
            }
            .navigationDestination(for: CMeasurement.self) { measurement in
                MeasurementDetailsView(measurement: measurement)
            .navigationTitle("Measurements")
            }
        } else {
            Text("No Measurements Found")
        }
    }
}

#Preview {
    MeasurementView()
        .environmentObject(AuthViewModel())
}

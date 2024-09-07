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
            Group {
                if let user = authViewModel.currentUser {
                    if let measurements = user.measurements, !measurements.isEmpty {
                        measurementsList(measurements: measurements)
                    } else {
                        Text("No Measurements Found")
                    }
                } else {
                    Text("Please log in to view measurements")
                }
            }
            .navigationTitle("Measurements")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    NavigationLink(value: "AddNewMeasurement") {
                        Image(systemName: "plus.square.fill")
                    }
                }
            }
        }
    
    private func measurementsList(measurements: [CMeasurement]) -> some View {
        
//        let user = authViewModel.currentUser!
//
//        let measurements = [
//                    CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 1"),
//                    CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 2"),
//                    CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 3"),
//                    CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 4"),
//                    CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 5"),
//                    CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 6"),
//                    CMeasurement(customer: user, forSelf: true, measurementFor: user.fullName, notes: "Hello World 7")
//        ]
        List {
            ForEach(measurements, id:\.notes) { measurement in
                NavigationLink(value: measurement) {
                    Text(measurement.notes)
                }
            }
        }
        .navigationDestination(for: CMeasurement.self) { measurement in
            MeasurementDetailsView(measurement: measurement)
        }
    }
}

#Preview {
    NavigationStack {
        MeasurementView()
            .environmentObject(AuthViewModel())
            .navigationDestination(for: String.self) { value in
                AddMeasurementView()
            }
    }
}

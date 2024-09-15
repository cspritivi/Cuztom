//
//  MeasurementView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 8/28/24.
//

import SwiftUI

struct MeasurementView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @Binding var path: NavigationPath
    
    var body: some View {
            Group {
                
                if let user = authViewModel.currentUser {
                    if let measurements = user.measurements, !measurements.isEmpty {
                        List {
                            ForEach(measurements, id: \.id) { measurement in
                                NavigationLink(value: measurement) {
                                    Text("Hello World")
                                }
                            }
                        }
                    } else {
                        Text("No Measurements Found")
                    }
                } else { Text("Please log in to view measurements") }
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
        List {
            ForEach(measurements, id:\.measurementFor) { measurement in
                NavigationLink(value: measurement) {
                    Text("Hello")
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
        MeasurementView(path: .constant(NavigationPath(["A", "B"])))
            .environmentObject(AuthViewModel())
            .navigationDestination(for: String.self) { value in
                AddMeasurementView(path: .constant(NavigationPath(["A", "B"])))
            }
    }
}

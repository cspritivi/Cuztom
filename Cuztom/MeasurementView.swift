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
    @State var isLoading: Bool = true
    @State private var measurements: [CMeasurement] = []
    
    var body: some View {
            Group {
                    if isLoading {
                        ProgressView()
                    } else if measurements.isEmpty {
                        Text("No Measurements Found")
                    } else {
                        List {
                            ForEach(measurements, id: \.id)  { measurement in
                                NavigationLink(value: measurement) {
                                    Text(measurement.type)
                                }
                            }
                        }
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
            .task {
                do {
                    try await fetchMeasurements()
                } catch {
                    //Error Handling for when fetchMeasurements crashes
                    print(error.localizedDescription)
                }
            }
            .navigationDestination(for: CMeasurement.self) { measurement in
                MeasurementDetailsView(measurement: measurement)
            }
        }
    
    private func fetchMeasurements() async throws {
        guard let user = authViewModel.currentUser else { isLoading = false; return }
        
        if let fetchedMeasurements = try await user.getMeasurements() {
            measurements = fetchedMeasurements
        }
        isLoading = false
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

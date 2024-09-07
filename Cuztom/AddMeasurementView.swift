//
//  AddMeasurementView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/6/24.
//

import SwiftUI

struct AddMeasurementView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    private let selectionOptions = ["Shirt", "Pant"]
    @State private var selected = ""
    @State private var forSelf = true
    @State private var measurementFor = ""
    
    var body: some View {
        measurementFor = authViewModel.currentUser?.fullName ?? "Not logged in"
//        guard  let user = authViewModel.currentUser else { return Text("No1 logged in") }
        return Form {
            Picker("Measurement Type", selection: $selected) {
                ForEach(selectionOptions, id:\.description) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
            Section("This Measure Is") {
                Toggle(isOn: $forSelf) {
                    Text("For Myself")
                    Text("Switch this off only if these measurements are someone else's")
                }
                .toggleStyle(.switch)
                TextField("Measurment For:", text: $measurementFor, prompt: Text("Full Name"))
                    .disabled(forSelf)
            }
            
        }
        .navigationTitle("Add New Measurment")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(value: "MeasurementDetails") {
                    Text("Next")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMeasurementView()
            .environmentObject(AuthViewModel())
    }
}

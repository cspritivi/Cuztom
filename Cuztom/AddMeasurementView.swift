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
        Form {
            Picker("Measurement Type", selection: $selected) {
                ForEach(selectionOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
            Section("This Measurement Is") {
                Toggle(isOn: Binding(
                    get: { forSelf },
                    set: { newValue in
                        forSelf = newValue
                        updateMeasurementFor()
                    }
                )) {
                    Text("For Myself")
                    Text("Switch this off only if these measurements are someone else's")
                }
                .toggleStyle(.switch)
                
                TextField("Measurement For:", text: $measurementFor, prompt: Text("Enter Name"))
                    .disabled(forSelf)
                    .foregroundColor(forSelf ? .gray : .black)
            }
        }
        .navigationTitle("Add New Measurement")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(value: "MeasurementDetails") {
                    Text("Next")
                }
            }
        }
        .onAppear {
            updateMeasurementFor()
        }
    }
    
    private func updateMeasurementFor() {
        if forSelf {
            measurementFor = authViewModel.currentUser?.fullName ?? ""
        } else {
            measurementFor = ""
        }
    }
}

#Preview {
    NavigationStack {
        AddMeasurementView()
            .environmentObject(AuthViewModel())
            .navigationDestination(for: String.self) { value in
                if value == "MeasurementDetails" {
                    MeasurementFormView()
                }
            }
    }
}

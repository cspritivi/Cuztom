//
//  AddMeasurementView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/6/24.
//

import SwiftUI

struct AddMeasurementView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var path: NavigationPath
    
    private let selectionOptions = Array(CMeasurement.typeToDetails.keys)
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
//                NavigationLink(value: "MeasurementDetails") {
//                    Text("Next")
//                }
//                .disabled(!formIsValid)
                NavigationLink {
                    MeasurementFormView(measurementFor: measurementFor, measurementType: selected, path: $path)
                } label: {
                    Text("Next")
                }
                .disabled(!formIsValid)

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

extension AddMeasurementView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return measurementFor != "" && selected != ""
    }
}

#Preview {
    NavigationStack {
        AddMeasurementView(path: .constant(NavigationPath(["A", "B"])))
            .environmentObject(AuthViewModel())
            .navigationDestination(for: String.self) { value in
                if value == "MeasurementDetails" {
                    MeasurementFormView(measurementFor: "Person", measurementType: "Shirt", path: .constant(NavigationPath(["A", "B"])))
                }
            }
    }
}

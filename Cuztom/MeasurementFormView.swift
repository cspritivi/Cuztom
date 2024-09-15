//
//  MeasurementFormView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/7/24.
//

import SwiftUI

struct MeasurementFormView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    let detailsNeeded:[String]
    @State var values:[String]
    @FocusState private var focusedField: Int?
    @Binding var path: NavigationPath
    
    let measurementFor: String
    let measurementType: String
    
    init( measurementFor: String, measurementType: String, path: Binding<NavigationPath>) {
        self.measurementFor = measurementFor
        self.measurementType = measurementType
        self.detailsNeeded = ShirtMeasurement.detailsNeeded
        self._values = State(initialValue: Array(repeating: "", count: detailsNeeded.count))
        self._path = path
    }
    
    var body: some View {
        Form {
            VStack {
                ForEach(0..<detailsNeeded.count, id:\.self) { index in
                    InputView(text: self.$values[index], title: self.detailsNeeded[index], placeholder: "Enter Details")
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: index)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Button(action: resetAllFields) {
                        Text("Reset")
                    }
                    Spacer()
                    Button(action: moveToPreviousField) {
                        Image(systemName: "chevron.up")
                    }
                    .disabled(!canMoveToPreviousField)
                    
                    Button(action: moveToNextField) {
                        Image(systemName: "chevron.down")
                    }
                    .disabled(!canMoveToNextField)
                    
                    Button { focusedField = nil } label: {
                        Text("Done")
                    }
                }
            }
        }
        .navigationTitle("New Shirt Measurement")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            Button("Submit") {
                let newMeasurement = CMeasurement(measurementFor: measurementFor, values: values, customerID: authViewModel.currentUser?.id ?? "")
                FirebaseManager.shared.addMeasurement(newMeasurement)
                path.removeLast(path.count)
            }
            .disabled(!formIsValid)
        })
    }
    
    private func moveToPreviousField() {
        guard let currentFocus = focusedField, currentFocus > 0 else { return }
        focusedField = currentFocus - 1
    }
    
    private var canMoveToPreviousField: Bool {
        guard let currentFocus = focusedField else { return false }
        return currentFocus > 0
    }
    
    private func moveToNextField() {
        guard let currentFocus = focusedField, currentFocus < self.detailsNeeded.count - 1 else { return }
        focusedField = currentFocus + 1
    }
    
    private var canMoveToNextField: Bool {
        guard let currentFocus = focusedField else { return false }
        return currentFocus < self.detailsNeeded.count - 1
    }
    
    private func resetAllFields() {
        for i in self.values.indices {
            self.values[i] = ""
        }
    }
}

extension MeasurementFormView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return self.values.allSatisfy { $0 != "" }
    }
}

#Preview {
    NavigationStack {
        MeasurementFormView(measurementFor: "C", measurementType: "D", path: .constant(NavigationPath(["A", "B"])))
            .environmentObject(AuthViewModel())
    }
}

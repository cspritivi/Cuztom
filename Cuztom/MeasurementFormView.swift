//
//  MeasurementFormView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/7/24.
//

import SwiftUI

struct MeasurementFormView: View {
    
    let detailsNeeded:[String]
    @State var values:[String]
    @FocusState private var focusedField: Int?
    
    init() {
        self.detailsNeeded = ShirtMeasurement.detailsNeeded
        self.values = Array(repeating: "", count: detailsNeeded.count)
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
                Spacer()
                HStack {
                    Button(action: moveToPreviousField) {
                        Image(systemName: "chevron.up")
                    }
                    .disabled(!canMoveToPreviousField)
                    
                    Button(action: moveToNextField) {
                        Image(systemName: "chevron.down")
                    }
                    .disabled(!canMoveToNextField)
                    
                    Button {
                        focusedField = nil
                    } label: {
                        Image(systemName: "checkmark")
                    }

                }
            }
        }
        .navigationTitle("New Shirt Measurement")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            Button("Done") {
                
            }
            .disabled(!(self.values.filter {$0 == ""}.count == 0))
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
}

#Preview {
    NavigationStack {
        MeasurementFormView()
    }
}

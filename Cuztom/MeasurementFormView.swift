//
//  MeasurementFormView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/7/24.
//

import SwiftUI

struct MeasurementFormView: View {
    
    let formFields = ["Chest", "Height"]
    @State var values: [Float] = [0, 0]
    @State var heightFeet = 0
    @State var heightInches = 0
    @State var heightFeet2 = 0
    @State var heightInches2 = 0
    
    var body: some View {
        Form {
            Section("Height") {
                HeightPickerField(feet: $heightFeet, inches: $heightInches, placeholder: "Tap to enter height")
                HeightPickerField(feet: $heightFeet2, inches: $heightInches2, placeholder: "Tap to enter height 2")
            }
        }
    }
}

#Preview {
    MeasurementFormView()
}

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
                        .submitLabel(.next)
                        .onSubmit {
                            print("formSubmited")
                        }
                }
            }
        }
    }
}

#Preview {
    MeasurementFormView()
}

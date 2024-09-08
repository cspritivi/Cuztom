//
//  ValuePickerView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/7/24.
//

import SwiftUI

struct ValuePickerView: View {
    @Binding var feet: Int
    @Binding var inches: Int
    
    let feetRange = 2...8 // Adjust this range as needed
    let inchesRange = 0...11
    
    var body: some View {
        HStack {
            Picker("Feet", selection: $feet) {
                ForEach(feetRange, id: \.self) { foot in
                    Text("\(foot) ft").tag(foot)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
            .clipped()
            
            Picker("Inches", selection: $inches) {
                ForEach(inchesRange, id: \.self) { inch in
                    Text("\(inch) in").tag(inch)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
            .clipped()
        }
    }
}

struct ValuePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ValuePickerView(feet: .constant(5), inches: .constant(8))
    }
}

//
//  MeasurementDetailsView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/5/24.
//

import SwiftUI

struct MeasurementDetailsView: View {
    
    let measurement: CMeasurement
    
    init(measurement: CMeasurement) {
        self.measurement = measurement
    }
    
    var body: some View {
        Text(self.measurement.measurementFor)
    }
}

#Preview {
//    MeasurementDetailsView(measurement)
    Text("Placeholder")
}

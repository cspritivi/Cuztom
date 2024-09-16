//
//  MeasurementDetailsView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/5/24.
//

import SwiftUI

struct MeasurementDetailsView: View {
    
    @State var measurement: CMeasurement?
    
    init(measurement: CMeasurement?) {
        self.measurement = measurement
    }
    
    var body: some View {
        
        Group {
            if let measurement = self.measurement {
                
                List {

                        Section("Measurement For") {
                            InfoRowView(title: measurement.measurementFor, tint: Color.black)
                        }
                        
                        Section("Measurement Type") {
                            InfoRowView(title: measurement.type, tint: Color.black)
                        }
                        
                        Section("Measurements") {
                            ForEach(0..<measurement.values.count, id:\.self) { index in
                                HStack {
                                    InfoRowView(title: CMeasurement.typeToDetails[measurement.type]![index], tint: Color.black)
                                    Spacer()
                                    Text("\(measurement.values[index])")
                                }
                            }
                        }
                }
                
            } else {
                ProgressView()
            }
        }
        .task {
            if self.measurement == nil {
                do {
                    self.measurement = try await MeasurementViewModel.shared.getMeasurement(id: "ABF09ED5-E441-4461-9E67-9F108A72AD9D")
                } catch {
                    // Error Handling
                }
            }
        }
    }
}

#Preview {
    MeasurementDetailsView(measurement: nil)
}

//
//  NewOrderView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/21/24.
//

import SwiftUI

struct OrderView: View {
    
    var body: some View {
        NavigationStack {
            Group {
                Text("Hellow World")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Fabrics", value: "DefaultFabrics")
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "DefaultFabrics": FabricsView(filter: "all")
                default: FabricsView(filter: "all")
                }
            }
        }
    }
}

#Preview {
    OrderView()
}

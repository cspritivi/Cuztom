//
//  StartOrderView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 10/5/24.
//

import SwiftUI

struct StartOrderView: View {
    let orderType: String
    var body: some View {
        Text(self.orderType)
    }
}

#Preview {
    StartOrderView(orderType: "Suit")
}

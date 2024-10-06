//
//  NewOrderView.swift
//  Cuztom
//
//  Created by Pritivi S Chhabria on 9/21/24.
//

import SwiftUI

struct OrderView: View {
    
    let types = ["Suit", "Shirt", "Pant", "Indian"]
    let images = [
        "Suit" : "Suit.png",
        "Shirt" : "Shirt.png",
        "Pant" : "Pant.png",
        "Indian" : "Indian.png"
    ]
    @ObservedObject var orderViewModel = OrderViewModel()
    
    var body: some View {
        NavigationStack {
            if orderViewModel.isLoading {
                ProgressView()
            } else {
                Group {
                    VStack {
                        Text("What are you looking for?")
                            .font(.largeTitle)
                        ScrollView {
                            orderTypeList
                                .padding(10)
                        }
                        
                        Spacer()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink("Browse Fabrics", value: "DefaultFabrics")
                    }
                }
                .navigationDestination(for: String.self) { value in
                    switch value {
                    case "DefaultFabrics": FabricsView(filter: "all")
                    default: StartOrderView(orderType: value)
                    }
                }
                .padding()
            }
        }
        .task {
            await orderViewModel.loadOrderTypeImages()
        }
    }
    
    var orderTypeList: some View {
        ForEach(self.types, id: \.self) { type in
            NavigationLink(value: type) {
                OrderTypeRowView(type: type, image: orderViewModel.orderTypeImages?[images[type]!] ?? UIImage(systemName: "photo")!)
            }
        }
    }
}

#Preview {
    OrderView()
}

//
//  MenuItemDetails.swift
//  littlelemon
//
//  Created by Michael Woodard on 16/03/23.
//

import SwiftUI

struct MenuItemDetails: View {
    let menuItem: Dish
    
    func formatPrice(priceStr: String) -> String {
        if let price = Float(priceStr) {
            let spacing = price < 10 ? " " : ""
            return "$ " + spacing + String(format: "%.2f", price)
        } else {
            return ""
        }
    }
    
    var body: some View {
        Form {
            Section {
                Text(menuItem.title!)
                    .font(.title.bold())
            }
            .frame(alignment: .center)
            .frame(maxWidth: .infinity, alignment: .center)
            Section {
                AsyncImage(url: URL(string: menuItem.image!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Section {
                Text("Price: \(formatPrice(priceStr: menuItem.price!))")
            }
            Section {
                Text("Description: \(menuItem.info!)")
                    .multilineTextAlignment(.leading)
            }
            Section {
                Text("Category: \(menuItem.category!)")
            }
            Spacer()
        }
        .scrollContentBackground(.hidden)
    }
}

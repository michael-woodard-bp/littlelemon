//
//  MenuItemDetails.swift
//  littlelemon
//
//  Created by Michael Woodard on 16/03/23.
//

import SwiftUI

struct MenuItemDetails: View {
    let menuItem: Dish
    
    var body: some View {
        VStack {
            Text(menuItem.title!)
            AsyncImage(url: URL(string: menuItem.image!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 400, height: 400)
            Text(menuItem.price!)
            Text(menuItem.info!)
            Text(menuItem.category!)
        }
    }
}

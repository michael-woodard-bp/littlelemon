//
//  MenuItem.swift
//  littlelemon
//
//  Created by Michael Woodard on 15/03/23.
//

import Foundation

struct MenuItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    let info: String
    let price: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey { case
        title = "title",
        info = "description",
        price = "price",
        image = "image",
        category = "category"
    }
}

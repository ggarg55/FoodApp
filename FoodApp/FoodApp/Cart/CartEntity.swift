//
//  CartEntity.swift
//  FoodApp
//
//  Created by Gourav Garg on 04/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation

struct CartData: Codable {
    let data: ItemData
    let selectedData: [Int: Int]
}

//
//  Category.swift
//  FoodApp
//
//  Created by Gourav Garg on 01/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation

public enum ApiError {
    case internetError(String)
    case serverMessage(String)
}


struct CategoryData: Codable {
    let categories: [String]
}

struct ItemData: Codable {
    let dish: [Dish]
}

// MARK: - Dish
struct Dish: Codable {
    let name, ingredients, weight, quantity : String
    var price: String
    let spicy: Bool
}

//
//  StringExtension.swift
//  FoodApp
//
//  Created by Gourav Garg on 01/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var dataEncoded: Data? {
        return self.data(using: .utf8)
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}

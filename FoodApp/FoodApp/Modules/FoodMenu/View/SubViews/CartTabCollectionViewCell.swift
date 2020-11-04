//
//  CartTabCollectionViewCell.swift
//  FoodApp
//
//  Created by Gourav Garg on 02/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit

class CartTabCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var aLabel: UILabel!
    
    func setTitle(tagName: String) {
        aLabel.text = tagName.uppercased()
        self.backgroundColor = UIColor(red: 229 / 255, green: 159 / 255, blue: 125 / 255, alpha: 1.0)
        aLabel.textColor = .black
    }
}

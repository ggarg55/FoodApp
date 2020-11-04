//
//  CartTableViewCell.swift
//  FoodApp
//
//  Created by Gourav Garg on 03/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var dImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(dish: Dish?) {
        if let data = dish {
            dImageView?.image = UIImage(named: data.name.lowercased())
            title.text = data.name
            price.text = data.price
        }
        layoutIfNeeded()
    }
    
}

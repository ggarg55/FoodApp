//
//  MainItemTableViewCell.swift
//  FoodApp
//
//  Created by Gourav Garg on 02/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainItemTableViewCell: UITableViewCell {
    @IBOutlet weak var dimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weightNumberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var qunatityLabel: UILabel!
    @IBOutlet weak var quantityDesLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cellContainerView: UIView!
    var dish: Dish?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
//        addButton.rx.tap
    }
    
    func configureCell(dish: Dish?, index: Int) {
        if let data = dish {
            dimageView?.image = UIImage(named: data.name.lowercased())
            titleLabel.text = data.name
            descriptionLabel.text = data.ingredients
            weightNumberLabel.text = data.weight
            qunatityLabel.text = data.quantity
            quantityDesLabel.text = "cm"
            addButton.setTitle(data.price, for: .normal)
        }
        cellContainerView.applyShadowWithCorner(radius: 50)
        layoutIfNeeded()
    }
}

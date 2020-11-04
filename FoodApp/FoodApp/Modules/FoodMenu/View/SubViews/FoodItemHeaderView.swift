//
//  FoodItemHeaderView.swift
//  FoodApp
//
//  Created by Gourav Garg on 02/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit
class FoodItemHeaderView: UIView {
    
}




/*
class FoodItemHeaderView: UIView {
    @IBOutlet weak var acollectionView: UICollectionView!
    
    var categories: [String] = ["Test 1", "Test 2", "Test 3"] {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.acollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        acollectionView.register(UINib(nibName: "CartTabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CartTabCollectionViewCell")
        acollectionView.delegate = self
        acollectionView.dataSource = self
    }
}

extension FoodItemHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartTabCollectionViewCell", for: indexPath) as! CartTabCollectionViewCell
        cell.setTitle(tagName: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == categories.count {
            // Tab selection action
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = calculateCellWidth(tagName: categories[indexPath.item])
        return CGSize(width: cellWidth, height: 30)
    }
    
    func calculateCellWidth(tagName: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 14)
        let labelWidth = tagName.size(OfFont: font).width
        let cellWidth = labelWidth + 50

        return cellWidth
    }
}
*/

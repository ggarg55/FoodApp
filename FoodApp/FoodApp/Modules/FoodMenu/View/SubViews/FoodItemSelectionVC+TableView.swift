//
//  FoodItemSelectionVC+TableView.swift
//  FoodApp
//
//  Created by Gourav Garg on 04/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension FoodItemSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.dish.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("FoodItemHeaderView", owner: self, options: nil)?.first as? FoodItemHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainItemTableViewCell", for: indexPath) as! MainItemTableViewCell
        cell.configureCell(dish: items.dish[indexPath.row], index: indexPath.row)
        _ = cell.addButton.rx.tap.asObservable().subscribe({_ in
            if let count = self.itemSelected[indexPath.row] {
                self.itemSelected[indexPath.row] = count + 1
            } else {
                self.itemSelected[indexPath.row] = 1
            }
            self.itemSelectedPublishSubject.onNext(self.itemSelected)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 472
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "shrinkOffer")))
    }
}

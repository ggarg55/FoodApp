//
//  CartViewController.swift
//  FoodApp
//
//  Created by Gourav Garg on 03/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController, Viewable {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CartPresenterInterface!
    var cartData = CartData(data: ItemData(dish: []), selectedData: [:])
    var data: [Dish] = []
    var updateData = PublishSubject<Void>()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.allowsSelection = false 
        self.view.applyShadowWithCorner(radius: 50)
    }
    
    fileprivate func registerCell() {
        tableView.register(UINib(nibName:"CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartData.selectedData.count > 0 {
            prepareData()
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("CartHeaderView", owner: self, options: nil)?.first as? CartHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.configureCell(dish: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = Bundle.main.loadNibNamed("CartFooterView", owner: self, options: nil)?.first as? CartFooterView
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    func prepareData() {
        var data: [Dish] = []
        for (k,v) in cartData.selectedData {
            var _data = cartData.data.dish[k]
            let price = Int(_data.price) ?? 0 * v
            _data.price = "\(price)"
            data.append(_data)
            self.data = data
        }
    }
}

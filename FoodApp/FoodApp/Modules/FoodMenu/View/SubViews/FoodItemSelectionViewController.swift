//
//  FoodItemSelectionViewController.swift
//  FoodApp
//
//  Created by Gourav Garg on 02/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FoodItemSelectionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items: ItemData = ItemData(dish: [])
    var itemSelected: [Int: Int] = [:]
    public let itemsPublishSubject : PublishSubject<ItemData> = PublishSubject()
    let disposeBag = DisposeBag()
    public let itemSelectedPublishSubject : PublishSubject<[Int: Int]> = PublishSubject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.allowsSelection = false
        self.view.applyShadowWithCorner(radius: 50)
        bindData()
    }
    
    fileprivate func registerCell() {
        tableView.register(UINib(nibName:"MainItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MainItemTableViewCell")
    }
    
    fileprivate func bindData() {
        _ = itemsPublishSubject.subscribe(
            onNext: {[weak self] in
                self?.items = $0
                self?.tableView.reloadData()
            }
        )
    }
}

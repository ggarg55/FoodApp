//
//  ViewController.swift
//  FoodApp
//
//  Created by Gourav Garg on 01/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit
import RxSwift

class FoodMenuViewController: UIViewController {
    let presenter = FoodMenuPresenter()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var offerContainerView: OfferViewController!
    @IBOutlet weak var tableContainerView: FoodItemSelectionViewController!
    @IBOutlet weak var cartValueLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    private let offerContainerSegueName = "offerContainerView"
    private let tableContainerSegueName = "tableContainerView"
    private let CartViewControllerSegueName = "CartViewController"
    
    public let itemsPublishSubject : PublishSubject<ItemData> = PublishSubject()
    var data: ItemData = ItemData(dish: [])
    var selectedItems: [Int: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.applyShadowWithCorner(radius: 15)
        NotificationCenter.default.addObserver(self, selector: #selector(shrink), name: NSNotification.Name(rawValue: "shrinkOffer"), object: nil)
        cartButton.applyShadowWithCorner(radius: 20)
        cartValueLabel.applyShadowWithCorner(radius: 10)
        cartButton.isHidden = true
        cartValueLabel.isHidden = true
        presenter.getCategory() // TODO: Use interface
        presenter.getItemList(path: kPizza, dataType: ItemData.self) // TODO: Use interface
        
//        cartButton.rx.tap.asDriver()
//            .drive(presenter.inputs.cartButtonTappedTrigger)
//            .disposed(by: disposeBag)
    }
    
    func bindTableView() {
        guard let vc = self.tableContainerView else {
            return
        }
        _ = vc.itemSelectedPublishSubject.subscribe(
            onNext: { [weak self] in
                self?.selectedItems = $0
                if self?.selectedItems.count ?? -1 > 0 {
                    self?.cartButton.isHidden = false
                    self?.cartValueLabel.isHidden = false
                    var total = 0
                    if let dict = self?.selectedItems {
                        dict.forEach { (arg0) in
                            total += arg0.value
                        }
                    }
                    self?.cartValueLabel.text = "\(total)"
                }
        })
        let _ = presenter.itemsPublishSubject.subscribe (
            onNext: {
                self.data = $0
                vc.itemsPublishSubject.onNext($0)
                print($0)
        },
            onError: {
                vc.itemsPublishSubject.onError($0)
                print($0)
        },
            onCompleted: {
                vc.itemsPublishSubject.onCompleted()
                print("completed")
        }
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        let myViewController = ViewController(nibName: "CartViewController", bundle: nil)
        //        self.present(myViewController, animated: true, completion: nil)
    }
    
    @objc func shrink() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.firstContainerViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == offerContainerSegueName {
            offerContainerView = segue.destination as? OfferViewController
            offerContainerView.height = firstContainerViewHeight.constant
        }
        if segue.identifier == tableContainerSegueName {
            tableContainerView = segue.destination as? FoodItemSelectionViewController
            bindTableView()
        }
        if segue.identifier == CartViewControllerSegueName {
            let vc = segue.destination as? CartViewController
            let cartData = CartData(data: data, selectedData: selectedItems)
            vc?.cartData = cartData
        }
    }
    
    
    @IBAction func cartButtonAction(_ sender: Any) {
        let cartData = CartData(data: data, selectedData: selectedItems)
        performSegue(withIdentifier: CartViewControllerSegueName, sender: nil)
        //TODO: Fix the router
        //presenter.cartButtonTappedTrigger.onNext(cartData)
    }
    
}


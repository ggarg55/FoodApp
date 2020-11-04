//
//  CartPresenter.swift
//  FoodApp
//
//  Created by Gourav Garg on 04/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CartPresenterInputs {
    var viewDidLoadTrigger: PublishSubject<Void> { get }
}

protocol CartPresenterOutputs {
    var viewConfigure: Observable<CartData> { get }
}

protocol CartPresenterInterface {
    var inputs: CartPresenterInputs { get }
    var outputs: CartPresenterOutputs { get }
}


final class CartPresenter: CartPresenterInterface, CartPresenterInputs, CartPresenterOutputs {
    var inputs: CartPresenterInputs { return self }
    var outputs: CartPresenterOutputs { return self }

    // Inputs
    let viewDidLoadTrigger = PublishSubject<Void>()

    // Outputs
    let viewConfigure: Observable<CartData>

    private let entryEntity: CartData
    private let dependencies: CartPresenterDependencies
    private let disposeBag = DisposeBag()

    init(entryEntity: CartData,
         dependencies: CartPresenterDependencies)
    {
        self.entryEntity = entryEntity
        self.dependencies = dependencies

        let _viewConfigure = PublishRelay<CartData>()
        self.viewConfigure = _viewConfigure.asObservable().take(1)

        viewDidLoadTrigger.asObservable()
            .subscribe(onNext: { [weak self] in
                _viewConfigure.accept(entryEntity)
            })
            .disposed(by: disposeBag)
    }
}

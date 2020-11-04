//
//  FoodMenuPresenter.swift
//  FoodApp
//
//  Created by Gourav Garg on 01/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FoodMenuPresetnerPresenterInputs {
    var viewDidLoadTrigger: PublishSubject<Void> { get }
    var cartButtonTappedTrigger: PublishSubject<CartData?> { get }
    var reachedBottomTrigger: PublishSubject<Void> { get }
    var addItemrigger: PublishSubject<IndexPath>  { get }
}

protocol FoodMenuPresenterOutputs {
    var apiResponse: BehaviorRelay<ItemData> { get }
    var isLoading: Observable<Bool> { get }
    var error: Observable<ApiError> { get }
}

protocol FoodMenuPresenterInterface {
    var inputs: FoodMenuPresetnerPresenterInputs { get }
    var outputs: FoodMenuPresenterOutputs { get }
}

typealias CartPresenterDependencies = (
    interactor: CartInteractor,
    router: CartRouterOutput
)

// : FoodMenuPresenterInterface
class FoodMenuPresenter: FoodMenuPresenterInterface, FoodMenuPresetnerPresenterInputs, FoodMenuPresenterOutputs {
    //let router = FoodMenuRouter()
    var viewDidLoadTrigger: PublishSubject<Void> = PublishSubject()
    
    var cartButtonTappedTrigger: PublishSubject<CartData?> = PublishSubject()
    
    var reachedBottomTrigger: PublishSubject<Void> = PublishSubject()
    
    var addItemrigger: PublishSubject<IndexPath> = PublishSubject()
    
    var apiResponse: BehaviorRelay<ItemData> = BehaviorRelay(value: ItemData(dish: []))
    
    var isLoading: Observable<Bool>
    
    var error: Observable<ApiError>
    
    var inputs: FoodMenuPresetnerPresenterInputs { return self}
    
    var outputs: FoodMenuPresenterOutputs { return self }
    
    let disposeBag = DisposeBag()
    
    let interactor = FoodMenuInteractor()
    
    public let categoriesPublishSubject : PublishSubject<CategoryData> = PublishSubject()
    public let itemsPublishSubject : ReplaySubject<ItemData> = ReplaySubject<ItemData>.create(bufferSize: 5)
    
    init() {
        isLoading = interactor.searchActionIsLoading
        error = interactor.searchActionError

        _ = cartButtonTappedTrigger.asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {
                    if let cartData = $0 {
                        print(cartData)
                        CartRouterInput().present(from: CartViewController(), entryEntity: cartData)
                    }
                }
            ).disposed(by: disposeBag)
    }
}

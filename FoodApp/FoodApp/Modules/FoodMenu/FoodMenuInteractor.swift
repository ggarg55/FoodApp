//
//  FoodMenuInteractor.swift
//  FoodApp
//
//  Created by Gourav Garg on 01/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class FoodMenuInteractor {
    fileprivate let provider = MoyaProvider<FoodAPI>()
    fileprivate let stubProvider = MoyaProvider<FoodAPI>(stubClosure: MoyaProvider.delayedStub(0.5), plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    var itemsList: [ItemData] = []
    
    // Outputs
    let searchResponse: Observable<ItemData> = PublishRelay<ItemData>().asObservable()
    var InterectorToPresenterSubject: PublishSubject<Void>?
    let searchActionIsLoading: PublishSubject<Bool> = PublishSubject()
    let searchActionError: PublishSubject<ApiError> = PublishSubject()
    
    // Dispose Bag
    private let disposeBag = DisposeBag()
    
}

extension FoodMenuInteractor {
    
    func fetchCategories() -> Observable<Response> {
        return stubProvider.rx.request(.getFoodCategories(nil))
            .asObservable()
            .retry(2)
            .filterSuccessfulStatusCodes()
    }
    
    func fetchFoodList(path: String) -> Observable<Response> {
        return stubProvider.rx.request(.getFoodList(subCat:path))
            .asObservable()
            .retry(2)
            .filterSuccessfulStatusCodes()
    }
}

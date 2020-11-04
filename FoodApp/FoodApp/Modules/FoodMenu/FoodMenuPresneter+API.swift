//
//  FoodMenuPresneter+API.swift
//  FoodApp
//
//  Created by Gourav Garg on 04/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension FoodMenuPresenter {
    
    func getCategory() {
        interactor.fetchCategories().asObservable().map{
            FAJSONParser<CategoryData>().decodeData(json: $0.data)
        }
        .subscribe (
            onNext: {
                $0.subscribe(onSuccess: { (categoryData) in
                    self.categoriesPublishSubject.onNext(categoryData)
                    print(categoryData)
                }) { (err) in
                    self.categoriesPublishSubject.onError(err)
                    print(err)
                }.dispose()
        },
            onCompleted: {
                self.categoriesPublishSubject.onCompleted()
                print("completed")
        }
        ).disposed(by: disposeBag)
    }
    
    func getItemList<T: Codable>(path: String, dataType: T.Type) {
        interactor.fetchFoodList(path: path).asObservable().map {
            FAJSONParser<T>().decodeData(json: $0.data)}
            .asObservable()
            .subscribe (
                onNext: {
                    $0.subscribeOn(MainScheduler.instance).subscribe(onSuccess: { (dataList) in
                        if let data = dataList as? ItemData {
                            self.itemsPublishSubject.onNext(data)
                        } else {
                            self.itemsPublishSubject.onError(NSError(domain: "", code: 5000, userInfo: nil))
                        }
                        print(dataList)
                    }) { (err) in
                        self.itemsPublishSubject.onError(err)
                        print(err)
                    }.dispose()
            },
                onCompleted: {
                    self.itemsPublishSubject.onCompleted()
                    print("completed")
            }
        ).disposed(by: disposeBag)
    }
}

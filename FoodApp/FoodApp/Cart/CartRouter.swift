//
//  CartRouter.swift
//  FoodApp
//
//  Created by Gourav Garg on 04/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation

struct CartRouterInput {

    private func view(entryEntity: CartData) -> CartViewController {
        let view = CartViewController()
        let interactor = CartInteractor()
        let dependencies = CartPresenterDependencies(interactor: interactor, router: CartRouterOutput(view))
        let presenter = CartPresenter(entryEntity: entryEntity, dependencies: dependencies)
        view.presenter = presenter
        return view
    }

    func push(from: Viewable, entryEntity: CartData) {
        let view = self.view(entryEntity: entryEntity)
        from.push(view, animated: true)
    }

    func present(from: Viewable, entryEntity: CartData) {
        from.present(view(entryEntity: entryEntity), animated: true)
    }
    
}

final class CartRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

}

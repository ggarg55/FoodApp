//
//  FoodMenuRouter.swift
//  FoodApp
//
//  Created by Gourav Garg on 04/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit

class FoodMenuRouter: Routerable {
    private(set) weak var view: Viewable!
    
    init(_ view: Viewable) {
        self.view = view
    }
}

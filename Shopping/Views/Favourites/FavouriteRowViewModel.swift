//
//  FavouriteRowViewModel.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 30/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import ShopKit

struct FavouriteRowViewModel: Identifiable {
    let id: ProductID
    let name: String
}

extension FavouriteRowViewModel {
    init(from model: Product) {
        id = model.id
        name = model.name
    }
}

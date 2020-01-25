//
//  ProductViewModel.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

struct ProductViewModel: Identifiable {
    let id: Int
    let name: String
    let price: String
    let oldPrice: String
    let category: String
    let available: Bool
}

extension ProductViewModel {
    func addToCart() {
        debugPrint(name)
    }
}

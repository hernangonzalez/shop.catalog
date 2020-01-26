//
//  Cart.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import Combine

public class Cart {
    private var cancellables: CancellableSet = .init()
    private let items: PassthroughSubject<[CartItem], Error> = .init()
    public init() { }
}

extension Cart {
    var allItems: AnyPublisher<[CartItem], Error> {
        items.eraseToAnyPublisher()
    }
}

public extension Cart {
    func update() {
        let api = ShopAPI.cart
        cancellables += URLSession.api
            .data(with: api)
            .subscribe(items)
    }

    func addProduct(with id: ProductID) -> AnyPublisher<Void, Error> {
        let kit = ShopKit()
        let add = kit.addCart(productId: id)
            .share()

        cancellables += add
            .map { ShopAPI.cart }
            .flatMap { URLSession.api.data(with: $0) }
            .subscribe(items)

        return add.eraseToAnyPublisher()
    }

    func remove(item id: CartID) {

    }
}

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
    private let session = URLSession.api
    private var cancellables: CancellableSet = .init()
    private let subject: PassthroughSubject<[CartItem], Error> = .init()
}

public extension Cart {
    var items: AnyPublisher<[CartItem], Error> {
        subject.eraseToAnyPublisher()
    }
}

public extension Cart {
    func update() {
        let api = ShopAPI.cart
        cancellables += URLSession.api
            .data(with: api)
            .subscribe(subject)
    }

    func addProduct(with id: ProductID) -> AnyPublisher<Void, Error> {
        let api = ShopAPI.addCart(productId: id)
        let add = session.data(with: api)
            .map { _ in }
            .share()

        cancellables += add
            .map { ShopAPI.cart }
            .flatMap { URLSession.api.data(with: $0) }
            .subscribe(subject)

        return add.eraseToAnyPublisher()
    }

    func remove(item id: CartID) -> AnyPublisher<Void, Error> {
        let api = ShopAPI.removeCart(id: id)
        let add = session.data(with: api)
            .map { _ in }
            .share()

        cancellables += add
            .map { ShopAPI.cart }
            .flatMap { URLSession.api.data(with: $0) }
            .subscribe(subject)

        return add.eraseToAnyPublisher()
    }
}

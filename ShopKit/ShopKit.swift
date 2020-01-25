//
//  ShopKit.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Combine
import Foundation

public enum KitError: Error {
    case badRequest
    case missing
}

public class ShopKit {
    public static let version = 1.0
    public init() { }
}

public extension ShopKit {
    func products() -> AnyPublisher<[Product], Error> {
        let api = ShopAPI.products
        return URLSession.api.data(with: api)
    }

    func cart() -> AnyPublisher<[CartItem], Error> {
        let api = ShopAPI.cart
        return URLSession.api.data(with: api)
    }

    func addCart(productId: ProductID) -> AnyPublisher<Void, Error> {
        let api = ShopAPI.addCart(productId: productId)
        let data = URLSession.api.data(with: api)
        return data.map { _ in }
            .eraseToAnyPublisher()
    }

    func removeCart(cartId: CartID) -> AnyPublisher<Void, Error> {
        let api = ShopAPI.removeCart(productId: cartId)
        let data = URLSession.api.data(with: api)
        return data.map { _ in }
            .eraseToAnyPublisher()
    }
}

//
//  Favourites.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 30/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import Combine

public class Favourites {
    private let defaults: UserDefaults
    private let subject: PassthroughSubject<Void, Never>

    init(store: UserDefaults) {
        defaults = store
        subject = .init()
    }
}

public extension Favourites {
    func add(product id: ProductID) {
        defaults.set(true, forKey: id.favouriteKey)
        subject.send()
    }

    func remove(product id: ProductID) {
        defaults.removeObject(forKey: id.favouriteKey)
        subject.send()
    }

    func isFavourite(_ id: ProductID) -> Bool {
        defaults.bool(forKey: id.favouriteKey)
    }

    var storeDidUpdate: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
}

private extension ProductID {
    var favouriteKey: String {
        "product- \(self)"
    }
}

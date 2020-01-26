//
//  Catalogue.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 26/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import Combine

public class Catalogue {
    private var cancellables: CancellableSet = .init()
    private let items: CurrentValueSubject<[Product], Error> = .init(.init())
}

public extension Catalogue {
    var products: AnyPublisher<[Product], Error> {
        items.eraseToAnyPublisher()
    }
}

public extension Catalogue {
    func update() {
        cancellables.cancel()
        cancellables += URLSession.api
            .data(with: ShopAPI.products)
            .subscribe(items)
    }
}

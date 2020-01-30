//
//  BrowserViewModel.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import Combine
import ShopKit

class BrowserViewModel {
    private var bindings = CancellableSet()
    private let needsUpdate: PassthroughSubject<Void, Never> = .init()

    // MARK: Dependencies
    private unowned let catalogue: Catalogue
    private unowned let cart: Cart
    private unowned let favourites: Favourites

    // MARK: Data
    private var items: [Product] = .init() {
        willSet { needsUpdate.send() }
    }
    private var cartCount: Int = .init() {
        willSet { needsUpdate.send() }
    }

    // MARK: Init
    init(cart: Cart, catalogue: Catalogue, favourites: Favourites) {
        self.cart = cart
        self.catalogue = catalogue
        self.favourites = favourites

        catalogue.products
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] in self.items = $0 })
            .store(in: &bindings)
    }
}

// MARK: - Presentation
extension BrowserViewModel: ObservableObject {
    var title: String { "Catalogue" }

    var products: [ProductViewModel] {
        items.map {
            .init(from: $0, cart: cart, favourites: favourites)
        }
    }

    var objectWillChange: AnyPublisher<Void, Never> {
        needsUpdate.eraseToAnyPublisher()
    }
}

// MARK: - Actions
extension BrowserViewModel {

    // MARK: Update
    func updateProducts() {
        cart.update()
        catalogue.update()
    }

    private func product(completion: Subscribers.Completion<Error>) {
    }

    private func product(items: [Product]) {
        self.items = items
    }
}


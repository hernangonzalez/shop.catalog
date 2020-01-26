//
//  CartViewModel.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 26/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import Combine
import ShopKit

struct CartItemViewModel: Identifiable {
    let id: CartID
    let name: String
    let price: String
}

class CartViewModel {
    private var bindings: CancellableSet = .init()
    private let needsUpdate: PassthroughSubject<Void, Never> = .init()

    // MARK: Dependencies
    private unowned let catalogue: Catalogue
    private unowned let cart: Cart

    // MARK: Data
    private var models: [CartItemViewModel] = .init() {
        willSet { needsUpdate.send() }
    }

    // MARK: Init
    init(cart: Cart, catalogue: Catalogue) {
        self.cart = cart
        self.catalogue = catalogue

        cart.items
            .combineLatest(catalogue.products)
            .map { $0.0.models(with: $0.1) }
            .catchError(with: .empty)
            .receive(on: DispatchQueue.main)
            .assign(to: \.models, on: self)
            .store(in: &bindings)
    }
}

// MARK: - Presentation
extension CartViewModel: ObservableObject {
    var title: String { "Cart" }
    var items: [CartItemViewModel] { models }

    var objectWillChange: AnyPublisher<Void, Never> {
        needsUpdate.eraseToAnyPublisher()
    }
}

private extension Array where Element == CartItem {
    func models(with products: [Product]) -> [CartItemViewModel] {
        compactMap { item in
            products
                .first { $0.id == item.productId }
                .map { CartItemViewModel(id: item.id, name: $0.name, price: $0.price) }
        }
    }
}

// MARK: - Actions
extension CartViewModel {
    func delete(item: CartItemViewModel) {
        debugPrint(item)
    }
}

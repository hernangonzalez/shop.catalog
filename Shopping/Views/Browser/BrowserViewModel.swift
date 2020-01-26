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
    private var cancellables = CancellableSet()
    private let needsUpdate: PassthroughSubject<Void, Never> = .init()

    // MARK: Dependencies
    private let source = ShopKit()
    private let cart = Cart()

    // MARK: Data
    private var items: [Product] = .init() {
        willSet { needsUpdate.send() }
    }
    private var cartCount: Int = .init() {
        willSet { needsUpdate.send() }
    }
}

// MARK: - Presentation
extension BrowserViewModel: ObservableObject {
    var title: String { "Catalog" }
    var sectionTitle: String { "Products" }

    var products: [ProductViewModel] {
        items.map {
            .init(from: $0, cart: cart)
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

        cancellables += source
            .products()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] in self.product(completion: $0) },
                  receiveValue: { [unowned self] in self.product(items: $0) })
    }

    private func product(completion: Subscribers.Completion<Error>) {
        debugPrint(completion)
    }

    private func product(items: [Product]) {
        self.items = items
    }
}


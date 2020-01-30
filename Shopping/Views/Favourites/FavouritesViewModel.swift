//
//  FavouritesViewModel.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 30/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import ShopKit
import Combine

class FavouritesViewModel {
    private var bindings = CancellableSet()
    private let needsUpdate: PassthroughSubject<Void, Never> = .init()

    // MARK: Dependencies
    private let store: Favourites

    // MARK: Data
    private var products: [Product] = .init() {
        willSet { needsUpdate.send() }
    }

    // MARK: Init
    init(catalogue: Catalogue, favourites: Favourites) {
        self.store = favourites

        favourites.storeDidUpdate
            .subscribe(needsUpdate)
            .store(in: &bindings)

        catalogue.products
            .receive(on: DispatchQueue.main)
            .assign(to: \.products, on: self)
            .store(in: &bindings)
    }
}

// MARK: - Presentation
extension FavouritesViewModel: ObservableObject {
    var title: String { "Favourites" }

    var items: [FavouriteRowViewModel] {
        products
            .filter { store.isFavourite($0.id) }
            .map { .init(from: $0) }
    }

    var objectWillChange: AnyPublisher<Void, Never> {
        needsUpdate.eraseToAnyPublisher()
    }
}


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
    private let queue = DispatchQueue(label: "queue.cart")
    private let session = URLSession.api
    private var cancellables: CancellableSet = .init()
    private let needsUpdate: PassthroughSubject<Void, Never> = .init()
    private let subject: PassthroughSubject<[CartItem], Never> = .init()
    private let errors: PassthroughSubject<Error, Never> = .init()

    init() {
        setupBindings()
    }

    private func setupBindings() {
        let update = session.data(with: ShopAPI.cart) as AnyPublisher<[CartItem], Error>
        needsUpdate
            .debounce(for: .milliseconds(300), scheduler: queue)
            .flatMap { update.catchError(with: .empty) }
            .sink(receiveValue: subject.send)
            .store(in: &cancellables)
    }
}

// MARK: - Content
public extension Cart {
    var items: AnyPublisher<[CartItem], Never> {
        subject.eraseToAnyPublisher()
    }

    var failure: AnyPublisher<Error, Never> {
        errors.eraseToAnyPublisher()
    }
}

// MARK: - Actions
public extension Cart {
    func update() {
        needsUpdate.send()
    }

    func addProduct(with id: ProductID) -> AnyPublisher<Void, Error> {
        let api = ShopAPI.addCart(productId: id)
        let action = session.data(with: api)
            .map { _ in }
            .share()

        action.catchError(with: .empty)
            .sink(receiveValue: needsUpdate.send)
            .store(in: &cancellables)

        return action.eraseToAnyPublisher()
    }

    func remove(item id: CartID) -> AnyPublisher<Void, Error> {
        let api = ShopAPI.removeCart(id: id)
        let action = session.data(with: api)
            .map { _ in }
            .share()

        action.catchError(with: .empty)
            .sink(receiveValue: needsUpdate.send)
            .store(in: &cancellables)

        return action.eraseToAnyPublisher()
    }
}

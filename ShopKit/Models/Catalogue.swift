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
    private let session: URLSession = .api
    private var cancellables: CancellableSet = .init()
    private let subject: PassthroughSubject<[Product], Never> = .init()
    private let errors: PassthroughSubject<Error, Never> = .init()
}

public extension Catalogue {
    var products: AnyPublisher<[Product], Never> {
        subject.eraseToAnyPublisher()
    }
}

public extension Catalogue {
    func update() {
        let products: AnyPublisher<[Product], Error> = session.data(with: ShopAPI.products)
        cancellables += products
            .sink(receiveCompletion: update(complete:),
                  receiveValue: update(products:))
    }

    private func update(complete: Subscribers.Completion<Error>) {
        switch complete {
        case .finished:
            break
        case let .failure(error):
            errors.send(error)
        }
    }

    private func update(products: [Product]) {
        subject.send(products)
    }
}

//
//  ProductViewModel.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import ShopKit
import Combine

enum ActionState {
    case enabled
    case disabled
    case inProgress
}

class ProductViewModel: Identifiable, ObservableObject {
    private var cancellables: CancellableSet = .init()

    // MARK: Dependencies
    private let cart: Cart

    // MARK: Data
    let id: ProductID
    private var stock: Int {
        didSet { addState = stock > 0 ? .enabled : .disabled }
    }

    // MARK: Presentation
    @Published var addState: ActionState = .enabled
    let name: String
    let price: String
    let oldPrice: String
    let category: String

    init(from model: Product, cart: Cart) {
        self.id = model.id
        self.name = model.name
        self.category = model.category
        self.price = model.price
        self.oldPrice = model.oldPrice ?? .init()
        self.stock = model.stock
        self.addState = model.available ? .enabled : .disabled
        self.cart = cart
    }
}

extension ProductViewModel {
    func add() {
        guard addState == .enabled else { return }

        addState = .inProgress
        cancellables += cart
            .addProduct(with: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self]  in self.addDidComplete($0) },
                  receiveValue: { })
    }

    private func addDidComplete(_ completion: Subscribers.Completion<Error>) {
        print(completion)
        stock -= 1
    }
}


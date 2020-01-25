//
//  Combine+Extensions.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import Combine

public extension Publisher {

    static var empty: AnyPublisher<Output, Failure> {
        Empty().eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        Fail(error: error).eraseToAnyPublisher()
    }

    static func just(_ value: Output) -> AnyPublisher<Output, Failure> {
        Just(value)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
}

public typealias CancellableSet = Array<AnyCancellable>

public extension CancellableSet {
    static func += (lhs: inout Array<Element>, rhs: Element) {
        lhs.append(rhs)
    }
}

public extension CancellableSet {
    func cancel() {
        forEach { $0.cancel() }
    }
}


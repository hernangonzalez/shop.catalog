//
//  ShopKit.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Combine
import Foundation

public enum KitError: Error {
    case badRequest
    case missing
}

public class ShopKit {
    public static let version = 1.0
}

// MARK: - Public
public extension ShopKit {
    static func catalogue() -> Catalogue {
        .init()
    }

    static func cart() -> Cart {
        .init()
    }
}

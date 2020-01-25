//
//  CartItem.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation

public typealias CartID = Int

public struct CartItem: Decodable, Identifiable {
    public let id: CartID
    public let productId: ProductID
}

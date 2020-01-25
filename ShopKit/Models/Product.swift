//
//  Product.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation

public typealias ProductID = Int

public struct Product: Decodable, Identifiable {
    public let id: ProductID
    public let name: String
    public let category: String
    public let price: String
    public let oldPrice: String?
    public let stock: Int
}

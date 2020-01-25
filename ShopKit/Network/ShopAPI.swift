//
//  ShopAPI.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation

enum ShopAPI {
    static let scheme = "https"
    static let host = "2klqdzs603.execute-api.eu-west-2.amazonaws.com"
    static let path = "/cloths"

    case products
    case cart
    case addCart(productId: ProductID)
    case removeCart(productId: ProductID)
}

extension ShopAPI: ShopRequest {
    var method: HTTPMethod {
        switch self {
        case .products, .cart:
            return .get
        case .addCart:
            return .post
        case .removeCart:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .products:
            return "products"
        case .cart, .addCart, .removeCart:
            return "cart"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case let .addCart(productId):
            return [.init(name: "productId", value: productId.description)]
        case let .removeCart(cartId):
            return [.init(name: "id", value: cartId.description)]
        default:
            return .init()
        }
    }
}



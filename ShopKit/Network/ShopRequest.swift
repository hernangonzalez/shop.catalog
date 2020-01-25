//
//  ShopRequest.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation

protocol ShopRequest: NetworkRequest {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension ShopRequest {

    var components: URLComponents {
        var components = URLComponents()
        components.scheme = ShopAPI.scheme
        components.host = ShopAPI.host
        components.path = [ShopAPI.path, path].joined(separator: "/")
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components
    }

    var headers: [String: String] {
        ["accept": "application/json",
         "X-API-KEY": ShopAPI.publicKey]
    }
}

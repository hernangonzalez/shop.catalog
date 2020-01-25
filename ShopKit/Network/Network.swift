//
//  Network.swift
//  ShopKit
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get, post, delete
}

protocol NetworkRequest {
    var components: URLComponents { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
}

// MARK: - URLSession
extension URLSession {
    static var api: URLSession { .shared }
}

extension URLSession {

    func data<T: Decodable>(with api: NetworkRequest) -> AnyPublisher<T, Error> {
        return data(with: api)
            .tryMap { try $0.decode() as T }
            .eraseToAnyPublisher()
    }

    func data(with api: NetworkRequest) -> AnyPublisher<Data, Error> {
        guard let url = api.components.url else {
            return .fail(KitError.badRequest)
        }

        var request = URLRequest(url: url)
        request.httpMethod = api.method.rawValue.uppercased()

        api.headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        return dataTaskPublisher(for: request)
            .map { $0.data }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

//
//  ProductRequest.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

struct ProductRequest: BaseRequest {
    typealias ResponseType = [Product]
    var endpoint: Endpoint
}

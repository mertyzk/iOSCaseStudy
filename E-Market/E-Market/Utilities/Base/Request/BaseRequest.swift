//
//  BaseRequest.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

protocol BaseRequest {
    associatedtype ResponseType: Codable
    var endpoint: Endpoint { get }
}

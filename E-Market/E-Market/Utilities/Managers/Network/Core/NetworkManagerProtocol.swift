//
//  NetworkManagerProtocol.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: BaseRequest>(_ request: T, completion: @escaping (Result<T.ResponseType, NetworkErrors>) -> Void)
}

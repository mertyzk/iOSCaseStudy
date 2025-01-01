//
//  NetworkErrors.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

enum NetworkErrors: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse  = "Invalid response from the server. Please try again."
    case invalidData      = "The data received from the server was invalid. Please try again."
    case invalidURL       = "Invalid URL. Please check URL."
}

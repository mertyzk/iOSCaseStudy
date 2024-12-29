//
//  DBErrors.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import Foundation

enum DBErrors: String, Error {
    case addObjectError  = "Failed to add the object to the database. Please try again later."
    case delObjectError  = "Failed to delete the object from the database. Please ensure the object exists and try again."
    case fetchDataError  = "Failed to fetch data from the database. Please check your connection or try again later."
    case toggleError     = "Failed to toggle the object's state. Please try again."
    case updObjectError  = "Failed to update the object in the database. Please check your input and try again."
    case addToCartError  = "Failed to add the item to the cart. Please try again."
    case removeCartError = "Failed to remove the item from the cart. Please ensure the item exists and try again."
    case clearCartError  = "Failed to clear the cart. Please try again later."
}


//
//  String+Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

extension String {
    func trimDecimalZeros() -> String {
        let characters = self.components(separatedBy: " ")
        var editedString: [String] = []

        for character in characters {
            if let value = Double(character) {
                if value.truncatingRemainder(dividingBy: 1) == 0 {
                    editedString.append(String(format: "%.0f", value))
                } else {
                    editedString.append(character)
                }
            } else {
                editedString.append(character)
            }
        }
        return editedString.joined(separator: " ")
    }
    
    
    func toDouble() -> Double {
         return Double(self) ?? 0.0
     }
}

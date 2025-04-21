//
//  DispatchQueue+Ext.swift
//  E-Market
//
//  Created by Macbook Air on 21.04.2025.
//

import Foundation

extension DispatchQueue {
    static func mainAsync(_ execute: @escaping () -> Void) {
        if Thread.isMainThread {
            execute()
        } else {
            DispatchQueue.main.async {
                execute()
            }
        }
    }
}

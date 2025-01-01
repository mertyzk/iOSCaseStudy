//
//  NotificationCenter+Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

extension Notification.Name {
    static let showLoading   = Notification.Name("showLoading")
    static let hideLoading   = Notification.Name("hideLoading")
    static let changeCartDB  = Notification.Name("changeCartDB")
    static let didFilter     = Notification.Name("didFilter")
    static let favUpdated    = Notification.Name("favUpdated")
}

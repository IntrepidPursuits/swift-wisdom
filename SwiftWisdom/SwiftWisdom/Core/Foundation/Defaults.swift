//
//  Comparables.swift
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

protocol SettingsKeyAccessible {
    var key: String { get }
    var defaults: NSUserDefaults { get }
}

extension SettingsKeyAccessible {
    var defaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    func writeToDefaults(any: AnyObject?) {
        if let any = any {
            defaults.setValue(any, forKey: key)
        } else {
            defaults.removeObjectForKey(key)
        }
        defaults.synchronize()
    }
    
    func readFromDefaults<T>() -> T? {
        return defaults.objectForKey(key) as? T
    }
}

protocol EnumSettingsKeyAccessible : SettingsKeyAccessible {
    var rawValue: String { get }
    init?(rawValue: String)
}

extension EnumSettingsKeyAccessible {
    var key: String {
        return rawValue
    }
}

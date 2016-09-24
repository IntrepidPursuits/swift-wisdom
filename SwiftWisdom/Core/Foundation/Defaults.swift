//
//  Comparables.swift
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

public protocol SettingsKeyAccessible {
    var key: String { get }
    var defaults: UserDefaults { get }
}

extension SettingsKeyAccessible {
    public var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    public func writeToDefaults(_ any: AnyObject?) {
        if let any = any {
            defaults.setValue(any, forKey: key)
        } else {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
    
    public func readFromDefaults<T>() -> T? {
        return defaults.object(forKey: key) as? T
    }
}

public protocol EnumSettingsKeyAccessible : SettingsKeyAccessible {
    var rawValue: String { get }
    init?(rawValue: String)
}

extension EnumSettingsKeyAccessible {
    public var key: String {
        return rawValue
    }
}

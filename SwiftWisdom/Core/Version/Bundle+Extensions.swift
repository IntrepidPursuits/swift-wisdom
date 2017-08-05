//
//  Bundle+Extensions.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/25/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension Bundle {

    /**
     Provides a way to access the current app version.
     - returns: String containing the current app version
     */
    public var ip_appVersion: String? {
        let key = "CFBundleShortVersionString"
        return infoDictionary?[key] as? String
    }

    /**
     Provides a way to access the current build number.
     - returns: String containing the current build number
     */
    public var ip_buildNumber: String? {
        let buildKey = "CFBundleVersion"
        return infoDictionary?[buildKey] as? String
    }
}

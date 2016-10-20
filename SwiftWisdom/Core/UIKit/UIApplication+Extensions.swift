//
//  UIApplication+Extensions.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

enum OpenSettingsError: Error {
    case cannotOpenURL
}

extension UIApplication {
    public func ip_openSettingsApp() throws {
        guard let url = URL(string: UIApplicationOpenSettingsURLString), canOpenURL(url) else {
            throw OpenSettingsError.cannotOpenURL
        }
        openURL(url)
    }
}

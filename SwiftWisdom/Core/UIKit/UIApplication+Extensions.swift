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

extension Intrepid where Base: UIApplication {
    public func openSettingsApp() throws {
        guard let url = URL(string: UIApplicationOpenSettingsURLString), canOpenURL(url) else {
            throw OpenSettingsError.cannotOpenURL
        }
        openURL(url)
    }
}

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

    @available(*, unavailable, message: "Call open(_:) directly using UIApplication.openSettingsURLString.\nSee ip_openSettingsApp source code for more details.")
    public func ip_openSettingsApp() throws {
        #if false
        guard let url = URL(string: UIApplication.openSettingsURLString), canOpenURL(url) else {
            throw OpenSettingsError.cannotOpenURL
        }
        open(url)
        #endif
    }
}

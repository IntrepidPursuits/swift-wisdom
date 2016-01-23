//
//  String+Localization.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension String {
    public func ip_localized(args: [CVarArgType] = [], comment: String = "") -> String {
        let localizedFormat = NSLocalizedString(self, comment: comment)
        return String(format: localizedFormat, arguments: args)
    }
}

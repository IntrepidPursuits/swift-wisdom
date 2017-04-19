//
//  UIViewController+NavigationItem.swift
//  SwiftWisdom
//
//  Created by David Brooks on 4/19/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import UIKit

extension UIViewController {
    // Note: This must be called on the previous view controller. For example, if A is to push B,
    // call this on A in order to hide B's back button title
    func ip_hideBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

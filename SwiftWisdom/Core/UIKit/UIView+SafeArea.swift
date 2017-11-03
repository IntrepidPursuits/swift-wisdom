//
//  UIView+SafeArea.swift
//  SwiftWisdom
//
//  Created by Persian, Alex on 11/3/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

extension UIView {

    /// Provides the view's edge insets with regards to the safe area.
    ///
    /// **11.0 and above**, returns `safeAreaInsets`
    ///
    /// **10.x and below**, returns `UIEdgeInsets.zero`
    var ip_safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    }

    /// Provides the view's top anchor with regards to the safe area.
    ///
    /// **Note:** for iOS 11 and above this anchor will not be available
    /// until after `viewDidAppear` is called
    var ip_safeAreaTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }

    /// Provides the view's bottom anchor with regards to the safe area.
    ///
    /// **Note:** for iOS 11 and above this anchor will not be available
    /// until after `viewDidAppear` is called
    var ip_safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }

    /// Provides the view's leading anchor with regards to the safe area.
    ///
    /// **Note:** for iOS 11 and above this anchor will not be available
    /// until after `viewDidAppear` is called
    var ip_safeAreaLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        } else {
            return self.leadingAnchor
        }
    }

    /// Provides the view's trailing anchor with regards to the safe area.
    ///
    /// **Note:** for iOS 11 and above this anchor will not be available
    /// until after `viewDidAppear` is called
    var ip_safeAreaTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.trailingAnchor
        } else {
            return self.trailingAnchor
        }
    }
}

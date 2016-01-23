//
//  UIView+Geometry.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension UIView {
    public var ip_width: CGFloat {
        return CGRectGetWidth(bounds)
    }
    public var ip_halfWidth: CGFloat {
        return ip_width / 2.0
    }
    public var ip_height: CGFloat {
        return CGRectGetHeight(bounds)
    }
    public var ip_halfHeight: CGFloat {
        return ip_height / 2.0
    }
}

extension UIView {
    public var ip_frameOrigin: CGPoint {
        get {
            return CGRectStandardize(frame).origin
        }
        set {
            frame.origin = newValue
        }
    }

    public var ip_frameSize: CGSize {
        get {
            return CGRectStandardize(frame).size
        }
        set {
            frame.size = newValue
        }
    }
    
    public var ip_frameX: CGFloat {
        get {
            return CGRectGetMinX(frame)
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var ip_frameY: CGFloat {
        get {
            return CGRectGetMinY(frame)
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var ip_frameWidth: CGFloat {
        get {
            return CGRectGetWidth(frame)
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var ip_frameHeight: CGFloat {
        get {
            return CGRectGetHeight(frame)
        }
        set {
            frame.size.height = newValue
        }
    }
    
    public var ip_frameMidX: CGFloat {
        get {
            return CGRectGetMidX(frame)
        }
        set {
            frame.origin.x = newValue - ip_halfWidth
        }
    }
    
    public var ip_frameMidY: CGFloat {
        get {
            return CGRectGetMidY(frame)
        }
        set {
            frame.origin.y = newValue - ip_halfHeight
        }
    }
    
    public var ip_frameMaxX: CGFloat {
        get {
            return CGRectGetMaxX(frame)
        }
        set {
            frame.origin.x = newValue - ip_width
        }
    }
    
    public var ip_frameMaxY: CGFloat {
        get {
            return CGRectGetMaxY(frame)
        }
        set {
            frame.origin.y = newValue - ip_height
        }
    }
    
    var ip_frameTopCenter: CGPoint {
        get {
            return CGPoint(x: ip_frameMidX, y: ip_frameY)
        }
        set(newTopCenter) {
            ip_frameY = newTopCenter.y
            ip_frameMidX = newTopCenter.x
        }
    }
}


extension UIView {
    public var ip_boundsOrigin: CGPoint {
        get {
            return CGRectStandardize(bounds).origin
        }
        set {
            bounds.origin = newValue
        }
    }
    
    public var ip_boundsSize: CGSize {
        get {
            return CGRectStandardize(bounds).size
        }
        set {
            bounds.size = newValue
        }
    }
    
    public var ip_boundsX: CGFloat {
        get {
            return CGRectGetMinX(bounds)
        }
        set {
            bounds.origin.x = newValue
        }
    }
    
    public var ip_boundsY: CGFloat {
        get {
            return CGRectGetMinY(bounds)
        }
        set {
            bounds.origin.y = newValue
        }
    }
    
    public var ip_boundsWidth: CGFloat {
        get {
            return CGRectGetWidth(bounds)
        }
        set {
            bounds.size.width = newValue
        }
    }
    
    public var ip_boundsHeight: CGFloat {
        get {
            return CGRectGetHeight(bounds)
        }
        set {
            bounds.size.height = newValue
        }
    }
    
    public var ip_boundsMidX: CGFloat {
        get {
            return CGRectGetMidX(bounds)
        }
        set {
            bounds.origin.x = newValue - ip_halfWidth
        }
    }
    
    public var ip_boundsMidY: CGFloat {
        get {
            return CGRectGetMidY(bounds)
        }
        set {
            bounds.origin.y = newValue - ip_halfHeight
        }
    }
    
    public var ip_boundsMaxX: CGFloat {
        get {
            return CGRectGetMaxX(frame)
        }
        set {
            bounds.origin.x = newValue - ip_width
        }
    }
    
    public var ip_boundsMaxY: CGFloat {
        get {
            return CGRectGetMaxY(bounds)
        }
        set {
            bounds.origin.y = newValue - ip_height
        }
    }
    
    public var ip_boundsTopCenter: CGPoint {
        get {
            return CGPoint(x: ip_boundsMidX, y: ip_boundsY)
        }
        set {
            ip_boundsY = newValue.y
            ip_boundsMidX = newValue.x
        }
    }
}

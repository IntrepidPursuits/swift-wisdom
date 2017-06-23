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
        return bounds.width
    }
    public var ip_halfWidth: CGFloat {
        return ip_width / 2.0
    }
    public var ip_height: CGFloat {
        return bounds.height
    }
    public var ip_halfHeight: CGFloat {
        return ip_height / 2.0
    }
}

extension UIView {
    public var ip_frameOrigin: CGPoint {
        get {
            return frame.standardized.origin
        }
        set {
            frame.origin = newValue
        }
    }

    public var ip_frameSize: CGSize {
        get {
            return frame.standardized.size
        }
        set {
            frame.size = newValue
        }
    }

    public var ip_frameX: CGFloat {
        get {
            return frame.minX
        }
        set {
            frame.origin.x = newValue
        }
    }

    public var ip_frameY: CGFloat {
        get {
            return frame.minY
        }
        set {
            frame.origin.y = newValue
        }
    }

    public var ip_frameWidth: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }

    public var ip_frameHeight: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }

    public var ip_frameMidX: CGFloat {
        get {
            return frame.midX
        }
        set {
            frame.origin.x = newValue - ip_halfWidth
        }
    }

    public var ip_frameMidY: CGFloat {
        get {
            return frame.midY
        }
        set {
            frame.origin.y = newValue - ip_halfHeight
        }
    }

    public var ip_frameMaxX: CGFloat {
        get {
            return frame.maxX
        }
        set {
            frame.origin.x = newValue - ip_width
        }
    }

    public var ip_frameMaxY: CGFloat {
        get {
            return frame.maxY
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
            return bounds.standardized.origin
        }
        set {
            bounds.origin = newValue
        }
    }

    public var ip_boundsSize: CGSize {
        get {
            return bounds.standardized.size
        }
        set {
            bounds.size = newValue
        }
    }

    public var ip_boundsX: CGFloat {
        get {
            return bounds.minX
        }
        set {
            bounds.origin.x = newValue
        }
    }

    public var ip_boundsY: CGFloat {
        get {
            return bounds.minY
        }
        set {
            bounds.origin.y = newValue
        }
    }

    public var ip_boundsWidth: CGFloat {
        get {
            return bounds.width
        }
        set {
            bounds.size.width = newValue
        }
    }

    public var ip_boundsHeight: CGFloat {
        get {
            return bounds.height
        }
        set {
            bounds.size.height = newValue
        }
    }

    public var ip_boundsMidX: CGFloat {
        get {
            return bounds.midX
        }
        set {
            bounds.origin.x = newValue - ip_halfWidth
        }
    }

    public var ip_boundsMidY: CGFloat {
        get {
            return bounds.midY
        }
        set {
            bounds.origin.y = newValue - ip_halfHeight
        }
    }

    public var ip_boundsMaxX: CGFloat {
        get {
            return frame.maxX
        }
        set {
            bounds.origin.x = newValue - ip_width
        }
    }

    public var ip_boundsMaxY: CGFloat {
        get {
            return bounds.maxY
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

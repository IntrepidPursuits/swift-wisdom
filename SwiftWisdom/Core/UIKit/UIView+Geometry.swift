//
//  UIView+Geometry.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension Intrepid where Base: UIView {
    public var width: CGFloat {
        return bounds.width
    }
    public var halfWidth: CGFloat {
        return ip.width / 2.0
    }
    public var height: CGFloat {
        return bounds.height
    }
    public var halfHeight: CGFloat {
        return ip.height / 2.0
    }
}

extension Intrepid where Base: UIView {
    public var frameOrigin: CGPoint {
        get {
            return frame.standardized.origin
        }
        set {
            frame.origin = newValue
        }
    }

    public var frameSize: CGSize {
        get {
            return frame.standardized.size
        }
        set {
            frame.size = newValue
        }
    }
    
    public var frameX: CGFloat {
        get {
            return frame.minX
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var frameY: CGFloat {
        get {
            return frame.minY
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var frameWidth: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var frameHeight: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    public var frameMidX: CGFloat {
        get {
            return frame.midX
        }
        set {
            frame.origin.x = newValue - ip.halfWidth
        }
    }
    
    public var frameMidY: CGFloat {
        get {
            return frame.midY
        }
        set {
            frame.origin.y = newValue - ip.halfHeight
        }
    }
    
    public var frameMaxX: CGFloat {
        get {
            return frame.maxX
        }
        set {
            frame.origin.x = newValue - ip.width
        }
    }
    
    public var frameMaxY: CGFloat {
        get {
            return frame.maxY
        }
        set {
            frame.origin.y = newValue - ip.height
        }
    }
    
    var frameTopCenter: CGPoint {
        get {
            return CGPoint(x: ip.frameMidX, y: ip.frameY)
        }
        set(newTopCenter) {
            ip.frameY = newTopCenter.y
            ip.frameMidX = newTopCenter.x
        }
    }
}


extension Intrepid where Base: UIView {
    public var boundsOrigin: CGPoint {
        get {
            return bounds.standardized.origin
        }
        set {
            bounds.origin = newValue
        }
    }
    
    public var boundsSize: CGSize {
        get {
            return bounds.standardized.size
        }
        set {
            bounds.size = newValue
        }
    }
    
    public var boundsX: CGFloat {
        get {
            return bounds.minX
        }
        set {
            bounds.origin.x = newValue
        }
    }
    
    public var boundsY: CGFloat {
        get {
            return bounds.minY
        }
        set {
            bounds.origin.y = newValue
        }
    }
    
    public var boundsWidth: CGFloat {
        get {
            return bounds.width
        }
        set {
            bounds.size.width = newValue
        }
    }
    
    public var boundsHeight: CGFloat {
        get {
            return bounds.height
        }
        set {
            bounds.size.height = newValue
        }
    }
    
    public var boundsMidX: CGFloat {
        get {
            return bounds.midX
        }
        set {
            bounds.origin.x = newValue - ip.halfWidth
        }
    }
    
    public var boundsMidY: CGFloat {
        get {
            return bounds.midY
        }
        set {
            bounds.origin.y = newValue - ip.halfHeight
        }
    }
    
    public var boundsMaxX: CGFloat {
        get {
            return frame.maxX
        }
        set {
            bounds.origin.x = newValue - ip.width
        }
    }
    
    public var boundsMaxY: CGFloat {
        get {
            return bounds.maxY
        }
        set {
            bounds.origin.y = newValue - ip.height
        }
    }
    
    public var boundsTopCenter: CGPoint {
        get {
            return CGPoint(x: ip.boundsMidX, y: ip.boundsY)
        }
        set {
            ip.boundsY = newValue.y
            ip.boundsMidX = newValue.x
        }
    }
}

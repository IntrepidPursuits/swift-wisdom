//
//  UIView+Geometry.swift
//
//  Created by Logan Wright on 10/24/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

public extension UIView {
    
    public var width: CGFloat {
        get {
            return CGRectGetWidth(frame)
        }
        set(width) {
            bounds.size.width = width
        }
    }
    
    public var halfWidth: CGFloat {
        return width / 2.0
    }
    
    public var height: CGFloat {
        get {
            return CGRectGetHeight(frame)
        }
        set(height) {
            bounds.size.height = height
        }
    }
    
    public var halfHeight: CGFloat {
        return height / 2.0
    }
    
    public var boundsCenter: CGPoint {
        return CGPoint(x: boundsMidX, y: boundsMidY)
    }
    
    public var boundsMidX: CGFloat {
        return CGRectGetMidX(bounds)
    }
    
    public var boundsMidY: CGFloat {
        return CGRectGetMidY(bounds)
    }
    
    public var frameMidX: CGFloat {
        get {
            return CGRectGetMidX(frame)
        }
        set(newMidX) {
            center.x = newMidX
        }
    }
    
    public var frameMidY: CGFloat {
        get {
            return CGRectGetMidY(frame)
        }
        set(newMidY) {
            center.y = newMidY
        }
    }
    
    public var smallestEdge: CGFloat {
        return min(width, height)
    }
}

//
//  Geometry.swift
//  Created by Logan Wright
//

import Foundation
import UIKit

public extension Int {
    public var ip_radians: CGFloat {
        return CGFloat(self).ip_radians
    }
}
public extension CGFloat {
    public var ip_radians: CGFloat {
        return CGFloat(Double(self) * (M_PI / 180))
    }
    public var ip_degrees: CGFloat {
        return self * CGFloat(180.0 / M_PI)
    }
}

public extension CGFloat {
    public var ip_squared: CGFloat {
        return self * self
    }
}

public extension CGPoint {
    public func ip_angleToPoint(comparisonPoint: CGPoint) -> CGFloat {
        let originX = comparisonPoint.x - self.x
        let originY = comparisonPoint.y - self.y
        let bearingRadians = atan2f(Float(originY), Float(originX))
        var bearingDegrees = CGFloat(bearingRadians).ip_degrees
        while bearingDegrees < 0 {
            bearingDegrees += 360
        }
        return bearingDegrees
    }
    
    public func ip_distanceToPoint(point: CGPoint) -> CGFloat {
        let distX = point.x - self.x
        let distY = point.y - self.y
        let distance = sqrt(distX.ip_squared + distY.ip_squared)
        return distance
    }
}

public func +=(inout left: CGPoint, right: CGPoint) {
    left.x += right.x
    left.y += right.y
}

public func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func random(range: Range<Int>) -> Int {
    guard let first = range.first, let last = range.last else { return 0 }
    assert(range.first >= 0)
    
    let diff = last - first
    let randomOffset = Int(arc4random_uniform(UInt32(diff)))
    let random = first + randomOffset
    return random
}

public func avg(numbers: CGFloat...) -> CGFloat {
    return numbers.reduce(0) { $0 + $1 } / CGFloat(numbers.count)
}

public func circumferenceForRadius(radius: CGFloat) -> CGFloat {
    return radius * CGFloat(M_PI * 2)
}

public func lengthOfArcForDegrees(degrees: CGFloat, radius: CGFloat) -> CGFloat {
    let circumference = circumferenceForRadius(radius)
    let percentage = degrees / 360.0
    return circumference * percentage
}

public func degreesForLengthOfArc(lengthOfArc: CGFloat, radius: CGFloat) -> CGFloat {
    let circumference = circumferenceForRadius(radius)
    let percentage = lengthOfArc / circumference
    return percentage * 360
}

public func pointWithCenter(center: CGPoint, radius: CGFloat, angleDegrees: CGFloat) -> CGPoint {
    let x = radius * cos(angleDegrees.ip_radians) + center.x
    let y = radius * sin(angleDegrees.ip_radians) + center.y
    return CGPoint(x: x, y: y)
}

public extension CGRect {
    public var ip_width: CGFloat {
        get {
            return CGRectGetWidth(self)
        }
        set(width) {
            size.width = width
        }
    }
    
    public var ip_halfWidth: CGFloat {
        get {
            return ip_width / 2.0
        }
        set {
            ip_width = newValue * 2
        }
    }
    
    public var ip_height: CGFloat {
        get {
            return CGRectGetHeight(self)
        }
        set(height) {
            size.height = height
        }
    }
    
    public var ip_halfHeight: CGFloat {
        get {
            return ip_height / 2.0
        }
        set {
            ip_height = newValue * 2
        }
    }
    
    public var ip_center: CGPoint {
        get {
            return CGPoint(x: ip_midX, y: ip_midY)
        }
        set {
            ip_midX = newValue.x
            ip_midY = newValue.y
        }
    }
    
    public var ip_midX: CGFloat {
        get {
            return CGRectGetMidX(self)
        }
        set {
            origin.x = newValue - ip_halfWidth
        }
    }
    
    public var ip_midY: CGFloat {
        get {
            return CGRectGetMidY(self)
        }
        set {
            origin.y = newValue - ip_halfHeight
        }
    }
    
    public var ip_shortestEdge: CGFloat {
        return min(ip_width, ip_height)
    }
    
    public var ip_longestEdge: CGFloat {
        return max(ip_width, ip_height)
    }
}

//
//  Geometry.swift
//  Created by Logan Wright
//

import Foundation
import UIKit

public extension Int {
    public var radians: CGFloat {
        return CGFloat(self).radians
    }
}
public extension CGFloat {
    public var radians: CGFloat {
        return CGFloat(Double(self) * (M_PI / 180))
    }
    public var degrees: CGFloat {
        return self * CGFloat(180.0 / M_PI)
    }
}

public extension CGFloat {
    public var squared: CGFloat {
        return self * self
    }
}

public extension CGPoint {
    public func angleToPoint(comparisonPoint: CGPoint) -> CGFloat {
        let originX = comparisonPoint.x - self.x
        let originY = comparisonPoint.y - self.y
        let bearingRadians = atan2f(Float(originY), Float(originX))
        var bearingDegrees = CGFloat(bearingRadians).degrees
        while bearingDegrees < 0 {
            bearingDegrees += 360
        }
        return bearingDegrees
    }
    
    public func distanceToPoint(point: CGPoint) -> CGFloat {
        let distX = point.x - self.x
        let distY = point.y - self.y
        let distance = sqrt(distX.squared + distY.squared)
        return distance
    }
}

public func +=(inout left: CGPoint, right: CGPoint) {
    left.x += right.x
    left.y += right.y
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
    let x = radius * cos(angleDegrees.radians) + center.x
    let y = radius * sin(angleDegrees.radians) + center.y
    return CGPoint(x: x, y: y)
}

public extension CGRect {
    public var width: CGFloat {
        get {
            return CGRectGetWidth(self)
        }
        set(width) {
            size.width = width
        }
    }
    
    public var halfWidth: CGFloat {
        get {
            return width / 2.0
        }
        set {
            width = newValue * 2
        }
    }
    
    public var height: CGFloat {
        get {
            return CGRectGetHeight(self)
        }
        set(height) {
            size.height = height
        }
    }
    
    public var halfHeight: CGFloat {
        get {
            return height / 2.0
        }
        set {
            height = newValue * 2
        }
    }
    
    public var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            midX = center.x
            midY = center.y
        }
    }
    
    public var midX: CGFloat {
        get {
            return CGRectGetMidX(self)
        }
        set {
            origin.x = newValue - halfWidth
        }
    }
    
    public var midY: CGFloat {
        get {
            return CGRectGetMidY(self)
        }
        set {
            origin.y = newValue - halfHeight
        }
    }
    
    public var shortestEdge: CGFloat {
        return min(width, height)
    }
    
    public var longestEdge: CGFloat {
        return max(width, height)
    }
}

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
        return CGFloat(Double(self) * (.pi / 180))
    }
    public var ip_degrees: CGFloat {
        return self * CGFloat(180.0 / .pi)
    }
}

public extension CGFloat {
    public var ip_squared: CGFloat {
        return self * self
    }
}

public extension CGPoint {
    public func ip_angle(to comparisonPoint: CGPoint) -> CGFloat {
        let originX = comparisonPoint.x - self.x
        let originY = comparisonPoint.y - self.y
        let bearingRadians = atan2f(Float(originY), Float(originX))
        var bearingDegrees = CGFloat(bearingRadians).ip_degrees
        while bearingDegrees < 0 {
            bearingDegrees += 360
        }
        return bearingDegrees
    }
    
    public func ip_distance(to point: CGPoint) -> CGFloat {
        let distX = point.x - self.x
        let distY = point.y - self.y
        let distance = sqrt(distX.ip_squared + distY.ip_squared)
        return distance
    }
}

public func circumferenceForRadius(_ radius: CGFloat) -> CGFloat {
    return radius * CGFloat.pi * 2
}

public func lengthOfArcForDegrees(_ degrees: CGFloat, radius: CGFloat) -> CGFloat {
    let circumference = circumferenceForRadius(radius)
    let percentage = degrees / 360.0
    return circumference * percentage
}

public func degreesForLengthOfArc(_ lengthOfArc: CGFloat, radius: CGFloat) -> CGFloat {
    let circumference = circumferenceForRadius(radius)
    let percentage = lengthOfArc / circumference
    return percentage * 360
}

public func pointWithCenter(_ center: CGPoint, radius: CGFloat, angleDegrees: CGFloat) -> CGPoint {
    let x = radius * cos(angleDegrees.ip_radians) + center.x
    let y = radius * sin(angleDegrees.ip_radians) + center.y
    return CGPoint(x: x, y: y)
}

public extension CGRect {
    public var ip_width: CGFloat {
        get {
            return self.width
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
            return self.height
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
            return self.midX
        }
        set {
            origin.x = newValue - ip_halfWidth
        }
    }
    
    public var ip_midY: CGFloat {
        get {
            return self.midY
        }
        set {
            origin.y = newValue - ip_halfHeight
        }
    }
    
    public var ip_shortestEdge: CGFloat {
        return min(width, height)
    }
    
    public var ip_longestEdge: CGFloat {
        return max(width, height)
    }
}

extension CGSize {
    public func ip_scaledHeight(keepingWidth fixedWidth: CGFloat) -> CGFloat {
        let scale = height / width
        return fixedWidth * scale
    }
    
    public func ip_scaledWidth(keepingHeight fixedHeight: CGFloat) -> CGFloat {
        let scale = width / height
        return fixedHeight * scale
    }
}

extension CGRect {
    public var ip_topLeft: CGPoint { return CGPoint(x: minX, y: minY) }
    public var ip_topRight: CGPoint { return CGPoint(x: maxX, y: minY) }
    public var ip_bottomRight: CGPoint { return CGPoint(x: maxX, y: maxY) }
    public var ip_bottomLeft: CGPoint { return CGPoint(x: minX, y: maxY) }
    
    public var ip_leftMiddle: CGPoint { return CGPoint(x: minX, y: midY) }
    public var ip_topMiddle: CGPoint { return CGPoint(x: midX, y: minY) }
    public var ip_rightMiddle: CGPoint { return CGPoint(x: maxX, y: midY) }
    public var ip_bottomMiddle: CGPoint { return CGPoint(x: midX, y: maxY) }
}

public func avg(_ points: CGPoint...) -> CGPoint {
    return avg(points)
}

public func avg(_ points: [CGPoint]) -> CGPoint {
    let count = CGFloat(points.count)
    let x = points.map { $0.x } .reduce(0, +) / count
    let y = points.map { $0.y } .reduce(0, +) / count
    return CGPoint(x: x, y: y)
}

// MARK: Operator Overloads

extension CGPoint {
    public static func += (left: inout CGPoint, right: CGPoint) {
        left.x += right.x
        left.y += right.y
    }

    public static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

extension CGSize {
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
}

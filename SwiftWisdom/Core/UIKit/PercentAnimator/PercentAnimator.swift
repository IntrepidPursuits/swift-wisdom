//
//  PercentAnimator.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 12/10/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import UIKit

// MARK: Public

public enum AnimationState {
    case Began
    case InProgress(percentComplete: CGFloat)
    case Completed
}

public extension UIView {
    public static func pa_percentAnimate(duration: NSTimeInterval, animation: AnimationState -> Void) {
        PercentAnimator.animateWithDuration(duration, animation: animation)
    }
}

extension AnimationState {
    public var isCompleted: Bool {
        switch self {
        case .Completed:
            return true
        default:
            return false
        }
    }
    
    public var percent: CGFloat {
        switch self {
        case .Began:
            return 0
        case let .InProgress(percentComplete: percent):
            return percent
        case .Completed:
            return 1
        }
    }
}

// MARK: Implementation


private final class PercentAnimator {
    
    private var animations: [Animation] = []
    
    private static let shared = PercentAnimator()
    
    private static func animateWithDuration(
        duration: NSTimeInterval,
        animation: AnimationState -> Void) {
            let id = NSUUID().UUIDString
            let wrapped: AnimationState -> Void = { state in
                if state.isCompleted {
                    shared.animations.ip_removeFirst { $0.id == id }
                }
                animation(state)
            }
            let anim = Animation(id: id, duration: duration, animation: wrapped)
            shared.animations.append(anim)
    }
}

private final class Animation {
    
    private let start: NSDate
    private let duration: NSTimeInterval
    
    private var displayLink: CADisplayLink!
    
    private(set) var state: AnimationState
    private let animation: AnimationState -> Void
    private let id: String
    
    private init(id: String, duration: NSTimeInterval, animation: AnimationState -> Void) {
        self.start = NSDate()
        self.duration = duration
        self.animation = animation
        self.state = .Began
        self.id = id
        
        
        displayLink = CADisplayLink(target: self, selector: #selector(Animation.displayLinkFired))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        animation(state)
    }
    
    private func cancel() {
        displayLink.invalidate()
    }
    
    dynamic private func displayLinkFired() {
        let percent = percentageCompleted()
        if percent < 1 {
            state = .InProgress(percentComplete: percent)
        } else {
            state = .Completed
            displayLink.invalidate()
        }
        animation(state)
    }
    
    private func percentageCompleted() -> CGFloat {
        let now = NSDate()
        let timePassed = now.timeIntervalSinceDate(start)
        return CGFloat(timePassed / duration)
    }
}

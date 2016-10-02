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
    case began
    case inProgress(percentComplete: CGFloat)
    case completed
}

public extension UIView {
    public static func pa_percentAnimate(_ duration: TimeInterval, animation: @escaping (AnimationState) -> Void) {
        PercentAnimator.animateWithDuration(duration, animation: animation)
    }
}

extension AnimationState {
    public var isCompleted: Bool {
        switch self {
        case .completed:
            return true
        default:
            return false
        }
    }
    
    public var percent: CGFloat {
        switch self {
        case .began:
            return 0
        case let .inProgress(percentComplete: percent):
            return percent
        case .completed:
            return 1
        }
    }
}

// MARK: Implementation


private final class PercentAnimator {
    
    private var animations: [Animation] = []
    
    private static let shared = PercentAnimator()
    
    static func animateWithDuration(
        _ duration: TimeInterval,
        animation: @escaping (AnimationState) -> Void) {
            let id = UUID().uuidString
            let wrapped: (AnimationState) -> Void = { state in
                if state.isCompleted {
                    shared.animations.ip_removeFirst { $0.id == id }
                }
                animation(state)
            }
            let anim = Animation(id: id, duration: duration, animation: wrapped)
            shared.animations.append(anim)
    }
}

final class Animation {
    
    private let start: Date
    private let duration: TimeInterval
    
    private var displayLink: CADisplayLink!
    
    private(set) var state: AnimationState
    private let animation: (AnimationState) -> Void
    fileprivate let id: String
    
    fileprivate init(id: String, duration: TimeInterval, animation: @escaping (AnimationState) -> Void) {
        self.start = Date()
        self.duration = duration
        self.animation = animation
        self.state = .began
        self.id = id
        
        
        displayLink = CADisplayLink(target: self, selector: #selector(Animation.displayLinkFired))
        displayLink.add(to: .main, forMode: .defaultRunLoopMode)
        animation(state)
    }
    
    private func cancel() {
        displayLink.invalidate()
    }
    
    dynamic private func displayLinkFired() {
        let percent = percentageCompleted()
        if percent < 1 {
            state = .inProgress(percentComplete: percent)
        } else {
            state = .completed
            displayLink.invalidate()
        }
        animation(state)
    }
    
    private func percentageCompleted() -> CGFloat {
        let now = Date()
        let timePassed = now.timeIntervalSince(start)
        return CGFloat(timePassed / duration)
    }
}

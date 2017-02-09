//
//  MulticastTests.swift
//  SwiftWisdom
//
//  Created by Son Le on 2/9/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

@objc private protocol BroadcasterDelegate: class {
    func broadcaster(_ broadcaster: Broadcaster, broadcasted message: String)
}

private class Broadcaster: NSObject, Multicast {

    typealias Delegate = BroadcasterDelegate
    var delegateReferences = [Weak<BroadcasterDelegate>]()

    func broadcast(that message: String) {
        for delegate in delegates {
            delegate.broadcaster(self, broadcasted: message)
        }
    }
}

private class Subscriber: BroadcasterDelegate {

    let closure: (String) -> Void

    init(_ closure: @escaping (String) -> Void) {
        self.closure = closure
    }

    func broadcaster(_ broadcaster: Broadcaster, broadcasted message: String) {
        closure(message)
    }
}

class MulticastTests: XCTestCase {

    func testAddingDelegates() {
        var messageRecipients = [String]()
        let subscriberA = Subscriber { message in
            if message == "We are intrepid" {
                messageRecipients.append("A")
            }
        }
        let subscriberB = Subscriber { message in
            if message == "We are intrepid" {
                messageRecipients.append("B")
            }
        }
        let subscriberC = Subscriber { message in
            if message == "We are intrepid" {
                messageRecipients.append("C")
            }
        }

        let broadcaster = Broadcaster()
        broadcaster.add(delegate: subscriberA)
        broadcaster.add(delegate: subscriberB)
        broadcaster.add(delegate: subscriberC)
        broadcaster.add(delegate: subscriberA)
        broadcaster.broadcast(that: "We are intrepid") // get it?
        if !messageRecipients.ip_contains(all: ["A", "B", "C"]) || messageRecipients.count != 3 {
            XCTFail("Intended recipients are A, B, and C. Actual recipients: \(messageRecipients)")
        }
    }

    func testRemovingOneDelegate() {
        var messageRecipients = [String]()
        let subscriberA = Subscriber { message in
            if message == "We are beautiful" {
                messageRecipients.append("A")
            }
        }
        let subscriberB = Subscriber { message in
            if message == "We are beautiful" {
                messageRecipients.append("B")
            }
        }
        let subscriberC = Subscriber { message in
            if message == "We are beautiful" {
                messageRecipients.append("C")
            }
        }

        let broadcaster = Broadcaster()
        broadcaster.add(delegate: subscriberA)
        broadcaster.add(delegate: subscriberB)
        broadcaster.add(delegate: subscriberC)
        broadcaster.remove(delegate: subscriberB)
        broadcaster.broadcast(that: "We are beautiful")
        if !messageRecipients.ip_contains(all: ["A", "C"]) || messageRecipients.count != 2 {
            XCTFail("Intended recipients are A and C. Actual recipients: \(messageRecipients)")
        }
    }

    func testRemovingMultipleDelegates() {
        var messageRecipients = [String]()
        let subscriberA = Subscriber { message in
            if message == "We are gorgeous" {
                messageRecipients.append("A")
            }
        }
        let subscriberB = Subscriber { message in
            if message == "We are gorgeous" {
                messageRecipients.append("B")
            }
        }
        let subscriberC = Subscriber { message in
            if message == "We are gorgeous" {
                messageRecipients.append("C")
            }
        }

        let broadcaster = Broadcaster()
        broadcaster.add(delegate: subscriberA)
        broadcaster.add(delegate: subscriberB)
        broadcaster.add(delegate: subscriberC)
        broadcaster.removeDelegates { $0 === subscriberA || $0 === subscriberC }
        broadcaster.broadcast(that: "We are gorgeous")
        if messageRecipients != ["B"] {
            XCTFail("Intended recipient is B. Actual recipients: \(messageRecipients)")
        }
    }
}

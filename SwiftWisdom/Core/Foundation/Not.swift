//
//  Not.swift
//  bmap
//
//  Created by Logan Wright on 12/11/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

/**
 Inverts a given boolean return closure
 
 Good for things like `array.filter(not(matchesThing))`
 */
public func not<T>(original: T -> Bool) -> T -> Bool {
    return {
        return !original($0)
    }
}

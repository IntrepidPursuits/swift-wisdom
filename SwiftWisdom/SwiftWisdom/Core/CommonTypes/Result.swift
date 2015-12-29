//
//  Result.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 11/13/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

public enum Result<T> {
    case Success(T)
    case Failure(ErrorType)
}

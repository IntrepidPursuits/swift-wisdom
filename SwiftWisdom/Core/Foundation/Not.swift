//
//  Not.swift
//  bmap
//
//  Created by Logan Wright on 12/11/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

/**
 Inverts a given boolean closure
 
      let newNames = ["Joe", "Betty"].filter(!existingNames.contains)
 */
public prefix func ! <T>(original: @escaping (T) -> Bool) -> (T) -> Bool {
    return { !original($0) }
}

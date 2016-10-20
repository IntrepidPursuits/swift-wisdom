//
//  SoundFile.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import AVFoundation

protocol SoundFile {
    var soundFile: String { get }
}

extension SoundFile {
    
    private var nameComponents: [String] {
        return soundFile.components(separatedBy: ".")
    }
    
    private var name: String {
        return nameComponents.first!
    }
    
    private var type: String {
        return nameComponents.last!
    }
    
    private var path: String {
        return Bundle.main.path(forResource: name, ofType: type)!
    }
    
    private var url: URL {
        return URL(fileURLWithPath: path)
    }
    
    func play() {
        var soundID: SystemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
        AudioServicesCreateSystemSoundID((url as CFURL), &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}

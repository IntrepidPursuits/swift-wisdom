//
//  VideoPlayer.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import AVKit
import AVFoundation

import IP_UIKit_Wisdom

// MARK: AV Extensions

extension AVAsset {
    public var naturalVideoSize: CGSize? {
        return tracksWithMediaType(AVMediaTypeVideo).first?.naturalSize
    }
}

extension AVPlayerViewController {
    public convenience init(player: AVPlayer) {
        self.init()
        self.player = player
    }
}

extension AVURLAsset {
    public convenience init(video: Video) {
        self.init(URL: video.url)
    }
}

extension AVPlayerItem {
    public convenience init(video: Video) {
        let asset = AVURLAsset(video: video)
        self.init(asset: asset)
    }
}

// MARK: Video

public struct Video {
    public let fileName: String
    public let type: String
    public let bundle: NSBundle
    
    public let url: NSURL
    
    public init?(fileName: String, type: String, bundle: NSBundle = NSBundle.mainBundle()) {
        self.fileName = fileName
        self.type = type
        self.bundle = bundle
        guard let url = bundle.URLForResource(fileName, withExtension: type) else { return nil }
        self.url = url
    }
}

// MARK: Player

public protocol VideoPlayerDelegate : class {
    /**
     The delegate is notified when the video finishes playing and returns 
     a boolean whether or not the video should repeat
     
     - parameter player: the player calling on the delegate
     
     - returns: a boolean indicating whether or not the video should start again
     */
    func videoPlayerDidFinish(player: VideoPlayer) -> Bool
}

/**
 Simple video player view controller meant to play a single video file
 with basic functionality of play / pause / prepeat
 */
public final class VideoPlayer : UIViewController {
    
    public let video: Video
    public weak var delegate: VideoPlayerDelegate?
    
    private let player: AVQueuePlayer
    private let playerController = AVPlayerViewController()
    
    // MARK: Initialization
    
    public init(video: Video, delegate: VideoPlayerDelegate? = nil) {
        self.video = video
        self.delegate = delegate
        
        let item = AVPlayerItem(video: video)
        self.player = AVQueuePlayer(items: [item])
        self.player.actionAtItemEnd = .Pause
        
        self.playerController.player = self.player
        super.init(nibName: nil, bundle: nil)
        
        setupItemNotification(item)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Play / Stop
    
    public func play() {
        player.play()
    }
    
    public func stop() {
        player.pause()
    }
    
    public func finishEarly() {
        player.pause()
        delegate?.videoPlayerDidFinish(self)
    }
    
    // MARK: Setup
    
    private func setup() {
        setupPlayer()
        view.backgroundColor = .whiteColor()
    }
    
    private func setupItemNotification(item: AVPlayerItem) {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(VideoPlayer.videoDidFinish(_:)),
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: item
        )
    }
    
    private func setupPlayer() {
        playerController.showsPlaybackControls = false
        playerController.view.backgroundColor = UIColor.whiteColor()
        ip_addChildViewController(playerController)
        view.constrainViewToAllEdges(playerController.view)
    }
    
    // MARK: Completion
    
    private func videoQueueComplete() {
        let shouldContinue = delegate?.videoPlayerDidFinish(self)
        if shouldContinue == true {
            restartVideoFromBeginning()
        }
    }
    
    public func restartVideoFromBeginning()  {
        player.seekToTime(kCMTimeZero)
        play()
    }
    
    // MARK: Notifications
    
    dynamic private func videoDidFinish(note: NSNotification) {
        videoQueueComplete()
    }
}

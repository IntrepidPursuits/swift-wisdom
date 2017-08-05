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
        return tracks(withMediaType: AVMediaTypeVideo).first?.naturalSize
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
        self.init(url: video.url)
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
    public let bundle: Bundle

    public let url: URL

    public init?(fileName: String, type: String, bundle: Bundle = Bundle.main) {
        self.fileName = fileName
        self.type = type
        self.bundle = bundle
        guard let url = bundle.url(forResource: fileName, withExtension: type) else { return nil }
        self.url = url
    }
}

extension Video {
    static public func == (lhs: Video, rhs: Video) -> Bool {
        return
            lhs.fileName == rhs.fileName &&
            lhs.type == rhs.type &&
            lhs.bundle == rhs.bundle &&
            lhs.url == rhs.url
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
    func videoPlayerDidFinish(_ player: VideoPlayer) -> Bool
}

/**
 Simple video player view controller meant to play a single video file
 with basic functionality of play / pause / prepeat
 */
public final class VideoPlayer: UIViewController {

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
        self.player.actionAtItemEnd = .pause

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
        _ = delegate?.videoPlayerDidFinish(self)
    }

    // MARK: Setup

    private func setup() {
        setupPlayer()
        view.backgroundColor = .white
    }

    private func setupItemNotification(_ item: AVPlayerItem) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(VideoPlayer.videoDidFinish(_:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: item
        )
    }

    private func setupPlayer() {
        playerController.showsPlaybackControls = false
        playerController.view.backgroundColor = UIColor.white
        ip_addChildViewController(playerController)
        view.constrainView(toAllEdges: playerController.view)
    }

    // MARK: Completion

    private func videoQueueComplete() {
        let shouldContinue = delegate?.videoPlayerDidFinish(self)
        if shouldContinue == true {
            restartVideoFromBeginning()
        }
    }

    public func restartVideoFromBeginning() {
        player.seek(to: kCMTimeZero)
        play()
    }

    // MARK: Notifications

    dynamic private func videoDidFinish(_ note: Notification) {
        videoQueueComplete()
    }
}

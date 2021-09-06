//
//  AudioHandler.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-03.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AVFoundation

class AudioHandler: NSObject {

    var playerItem: AVPlayerItem!
    var audioPlayer: AVPlayer!
    
    override init() {
        super.init()
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!))
        audioPlayer = AVPlayer(playerItem: playerItem)
    }
    
    func createAudioPlayer(songLink: String) {
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: songLink))
        audioPlayer = AVPlayer(playerItem: playerItem)
    }

    func start() {
        self.audioPlayer.play()
    }
    
    func pause(){
        self.audioPlayer?.pause()
    }
    
    func removeAllObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

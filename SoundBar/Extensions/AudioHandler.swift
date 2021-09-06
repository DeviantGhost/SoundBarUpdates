//
//  AudioHandler.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-03.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

var duration = 0.0
var currentTimeStamp = ""
var percentageDone = 0.0
var currentTimeMins = "0:00"
var currentTimeSeconds = 0.0

import AVFoundation
var isPlayingSong: Bool!


class AudioHandler: NSObject {
    
    private var playerItemFull: AVPlayerItem?
    private var playerItemClip: AVPlayerItem?
    private var audioPlayerFull: AVPlayer?
    private var audioPlayerClip: AVPlayer?
    private var timer: Timer?
    
    private var snippetAudioLink: String = ""
    private var fullAudioLink: String = ""
    
    private var homeSongNumber: Int = 0
    private var datasourceSongNumber: Int = 0

    var dataSource: [SongPresentation]?
    var getFullPlayerItem: AVPlayerItem { return playerItemFull! }
    var getShortPlayerItem: AVPlayerItem { return playerItemClip! }
    var getSongNumber: Int { return self.homeSongNumber }
    var getDataSourceNumber: Int { return self.datasourceSongNumber }
    var getSnippetLink: String { return self.snippetAudioLink }
    var getFullLink: String { return self.fullAudioLink }
    var getFullPlayer: AVPlayer { return self.audioPlayerFull! }
    var getSnippetPlayer: AVPlayer { return self.audioPlayerClip! }

    override init() {
        super.init()
        playerItemFull = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: fullAudioLink, ofType: "mp3")!))
        playerItemClip = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: snippetAudioLink, ofType: "mp3")!))
        
        audioPlayerFull = AVPlayer(playerItem: playerItemFull)
        audioPlayerClip = AVPlayer(playerItem: playerItemClip)
        
        self.audioPlayerFull?.seek(to: .zero)
        self.audioPlayerClip?.seek(to: .zero)
    }
    
    func createAudioPlayer(songLink: String) {
        
        playerItemFull = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: fullAudioLink, ofType: "mp3")!))
        playerItemClip = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: snippetAudioLink, ofType: "mp3")!))
        
        audioPlayerFull = AVPlayer(playerItem: playerItemFull)
        audioPlayerClip = AVPlayer(playerItem: playerItemClip)
        
    }
    
    func setDataSource(data: [SongPresentation]) {
        dataSource = data
    }
    
    func setSnippetAudioLink(snippetLink: String) {
        self.snippetAudioLink = snippetLink
        self.playerItemClip = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: snippetAudioLink, ofType: "mp3")!))
        
        audioPlayerClip = AVPlayer(playerItem: playerItemClip)
    }
    
    func setFullAudioLink(fullLink: String) {
        self.fullAudioLink = fullLink
        self.playerItemFull = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: fullAudioLink, ofType: "mp3")!))
        audioPlayerFull = AVPlayer(playerItem: playerItemFull)
    }
    
    func setCurrentSongNumber(number: Int) {
        self.homeSongNumber = number
    }
    
    func setDatasourceSongNumber(number: Int) {
        self.datasourceSongNumber = number
    }
    
    func setCurrentTime(time: CMTime){
        globalAudioPlayer?.audioPlayerFull?.seek(to: time)
        
    }
    
    func getCurrentTime() -> Float64 {
        print("currentTime: \(CMTimeGetSeconds(globalAudioPlayer?.audioPlayerFull?.currentTime() ?? CMTime()))")
        return CMTimeGetSeconds(globalAudioPlayer?.audioPlayerFull?.currentTime() ?? CMTime())
        
    }
    
    func playFullSong(){
        globalAudioPlayer?.audioPlayerFull?.play()
        isPlayingSong = true
        
    }
    
    func pauseFullSong(){
        
        globalAudioPlayer?.audioPlayerFull?.pause()
        isPlayingSong = false
        
    }
    
    func homePlayFullSong(){
        
        audioPlayerFull!.play()
        isPlayingSong = true
    }
    
    func homePlayPauseSong(){
        
        audioPlayerFull!.pause()
        isPlayingSong = false

    }
    func togglePlay() {
        
        if isPlayingSong {
            globalAudioPlayer?.audioPlayerFull?.pause()

            isPlayingSong = false
        }else{
            globalAudioPlayer?.audioPlayerFull?.play()

            isPlayingSong = true

        }
    }
    
    func startFull() {
        
        audioPlayerFull!.pause()
        audioPlayerClip!.pause()
        
        self.audioPlayerFull?.play()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            formatter.minimumIntegerDigits = 1
            formatter.maximumIntegerDigits = 4
            formatter.maximumFractionDigits = 3
            
            let urlLong  = URL.init(string: self.fullAudioLink)
            self.playerItemFull = AVPlayerItem(url: urlLong!)
            
            //percentageDone = (Double(movedTimeSeconds) / duration)
            currentTimeSeconds = CMTimeGetSeconds(self.audioPlayerFull!.currentTime())
            //currentTimeMins = self.formatTimeFor(seconds: currentTimeSeconds)
            //            currentTime = currentTimeMins
            
//            print("Percentage Done: \(percentageDone)")
//            print("Duration: \(duration)")
//            print("Current Time: \(String(describing: currentTimeMins))")
            
            
            //print(percentageDone)
            //print("Percentage Done: \(formattedPercentage ?? "0")")
            if isPlaying == false {
                timer.invalidate()
            }
        }
    }

    func pauseCurrentSong() {
        if fullSongOpen {
            self.audioPlayerFull!.pause()
            self.audioPlayerFull!.seek(to: self.audioPlayerFull!.currentTime())
            currentTimeSeconds = CMTimeGetSeconds(self.audioPlayerFull!.currentTime())
            percentageDone = (Double(movedTimeSeconds) / duration)
            //currentTimeMins = self.formatTimeFor(seconds: currentTimeSeconds)
        } else {
            self.audioPlayerClip!.pause()
            if CMTime(seconds: self.audioPlayerClip!.currentItem!.currentTime().seconds, preferredTimescale: 1).isValid {
                print("is a valid time")
                self.audioPlayerClip!.seek(to: self.audioPlayerClip!.currentItem!.currentTime())
            }
        }
    }
    
    
    
    func unpauseCurrentSong() {
        print("play: unpause \(fullSongOpen)")
        if fullSongOpen {
            self.audioPlayerFull!.play()
            isPlayingSong = true

            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (timer) in
//                print("UnpauseFull :")
                //percentageDone = (Double(movedTimeSeconds) / duration)
                currentTimeSeconds = CMTimeGetSeconds(self.audioPlayerFull!.currentTime())
                //currentTimeMins = self.formatTimeFor(seconds: currentTimeSeconds)
//                print("Percentage Done: \(percentageDone)")
//                print("Duration: \(duration)")
//                print("MoveTimeSeconds: \(movedTimeSeconds)")
//                print("CurrentTimeSeconds: \(currentTimeSeconds)")
                
                
                //currentTime = currentTimeMins
                
                if isPlaying == false {
                    print("TIMER STOPPPPPPPEDDDDD")
                    timer.invalidate()
                }
            }
            
        } else {
            self.audioPlayerClip!.play()
            isPlayingSong = true
        }
    }
    
    func playClip(){
        self.audioPlayerClip!.play()
        isPlayingSong = true
        if homeFeedTab == false{
            previewAlreadyPlaying = true
        }
    }
    
    func pauseClip(){
        self.audioPlayerClip!.pause()
        isPlayingSong = false
        previewAlreadyPlaying = false
    }
        
    func startClip() {
        
        audioPlayerFull!.pause()
        audioPlayerClip!.pause()
                
        playerItemFull = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: fullAudioLink, ofType: "mp3")!))
        playerItemClip = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: snippetAudioLink, ofType: "mp3")!))
        
        audioPlayerFull = AVPlayer(playerItem: playerItemFull)
        audioPlayerClip = AVPlayer(playerItem: playerItemClip)
        
        self.audioPlayerClip?.play()
        
        duration = Double(playerItemFull!.asset.duration.value) / Double(playerItemFull!.asset.duration.timescale)
        
        print(duration)
        
        isPlayingSong = true

    }
    
    func stopAllAudio() {
        self.audioPlayerFull?.pause()
        self.audioPlayerClip?.pause()
        isPlayingSong = false

    }
    
    func restart() {
        timer?.invalidate()
        self.audioPlayerFull?.seek(to: .zero)
        self.audioPlayerClip?.seek(to: .zero)
    }
    
    func restartFull() {
        timer?.invalidate()
        self.audioPlayerFull?.seek(to: .zero)
    }
    
    func updateSong() {
        
        playerItemFull = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: fullAudioLink, ofType: "mp3")!))
        playerItemClip = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: snippetAudioLink, ofType: "mp3")!))
        
        audioPlayerFull = AVPlayer(playerItem: playerItemFull)
        audioPlayerClip = AVPlayer(playerItem: playerItemClip)
    }
    
}

//
//  BackgroundImageNode.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-01.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation

var isPlaying: Bool!
var successType = ""

class BackgroundImageNode: BaseNode {
    
    let imageNode = ASImageNode()
    
    let playButton = ASImageNode()
    let pauseButton = ASImageNode()
    
    var successBox = ASImageNode()
    var successText = ASTextNode()
    
    var spaceBelow: CGFloat!
    var imageLink: String?
    var audioPlayer: AudioHandler!
<<<<<<< Updated upstream
    var isPLaying = false
    var playerItem: AVPlayerItem!
=======
>>>>>>> Stashed changes
    
    var didAddGradient = false
    
    init(space: Double?, artworkLink: String?, audio: AudioHandler!) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(success), name: NSNotification.Name("success"), object: nil)
        
        imageLink = artworkLink
        spaceBelow = CGFloat(space!)
        audioPlayer = audio
    
        setupNode()
//        playerItem = AVPlayerItem(url: )
        audioPlayer = AudioHandler()
        playerItem = audioPlayer.playerItem
    }
    
    override func didEnterVisibleState() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playPause))
        tapGesture.numberOfTapsRequired = 1
        imageNode.view.addGestureRecognizer(tapGesture)
        
        playButton.image = UIImage(named: "HomePlayButton")
        playButton.alpha = 0
        playButton.zPosition = 100
        playButton.style.preferredSize = CGSize(width: 45, height: 45)
        playButton.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 22.5, y: UIScreen.main.bounds.height / 2 - 45, width: 45, height: 45)
        view.layer.addSubnode(playButton)
        
        pauseButton.image = UIImage(named: "HomePauseButton")
        pauseButton.alpha = 0
        pauseButton.zPosition = 100
        pauseButton.style.preferredSize = CGSize(width: 45, height: 45)
        pauseButton.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 22.5, y: UIScreen.main.bounds.height / 2 - 45, width: 45, height: 45)
        view.layer.addSubnode(pauseButton)
        
        if didAddGradient == false{
            imageNode.gradient(from: UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1), to: UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 0))
            didAddGradient = true
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let background = ASInsetLayoutSpec(insets: .zero, child: imageNode)
        
        return background
    }
    
    private func setupNode() {
        if !fullSongOpen{
            imageNode.image = UIImage(named: imageLink!)
        }
        imageNode.contentMode = .scaleAspectFill
        imageNode.style.preferredSize.width = UIScreen.main.bounds.width
        imageNode.style.preferredSize.height = UIScreen.main.bounds.height - CGFloat(spaceBelow)
        imageNode.zPosition = 0
        imageNode.addTarget(self, action: #selector(playPause), forControlEvents: .touchUpInside)
    }
    
    @objc func success() {
        print("success")
        if successType == "Repost" {
            successBox.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            successBox.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 60, y: UIScreen.main.bounds.height / 2 - 65, width: 120, height: 40)
            successBox.cornerRadius = 10
            successBox.zPosition = 100
            successBox.alpha = 1
            view.addSubnode(successBox)
            
            successText.attributedText = NSAttributedString(string: "Reposted", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
            let textSize = successText.sizeOfString(font: UIFont.systemFont(ofSize: 15))
            
            successText.zPosition = 110
            successText.alpha = 1
            successText.frame.size = textSize
            successText.frame.size.width += 2
            successText.position.y += 1
            successText.position = successBox.position
            view.addSubnode(successText)
        }
        
        if successType == "Favorited" {
            successBox.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            successBox.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 60, y: UIScreen.main.bounds.height / 2 - 65, width: 120, height: 40)
            successBox.cornerRadius = 10
            successBox.zPosition = 100
            successBox.alpha = 1
            view.addSubnode(successBox)
            
            successText.attributedText = NSAttributedString(string: "Favorited", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
            let textSize = successText.sizeOfString(font: UIFont.systemFont(ofSize: 15))
            
            successText.zPosition = 110
            successText.alpha = 1
            successText.frame.size = textSize
            successText.frame.size.width += 2
            successText.position.y += 1
            successText.position = successBox.position
            view.addSubnode(successText)
        }
        
        if successType == "Added To Playlist" {
            successBox.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            successBox.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 70, y: UIScreen.main.bounds.height / 2 - 65, width: 140, height: 40)
            successBox.cornerRadius = 10
            successBox.zPosition = 100
            successBox.alpha = 1
            view.addSubnode(successBox)
            
            successText.attributedText = NSAttributedString(string: "Added To Playlist", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
            let textSize = successText.sizeOfString(font: UIFont.systemFont(ofSize: 15))
            
            successText.zPosition = 110
            successText.alpha = 1
            successText.frame.size = textSize
            successText.frame.size.width += 2
            successText.position.y += 1
            successText.position = successBox.position
            view.addSubnode(successText)
        }
        
        if successType == "Sent" {
            successBox.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            successBox.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 60, y: UIScreen.main.bounds.height / 2 - 65, width: 120, height: 40)
            successBox.cornerRadius = 10
            successBox.zPosition = 100
            successBox.alpha = 1
            view.addSubnode(successBox)
            
            successText.attributedText = NSAttributedString(string: "Sent", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
            let textSize = successText.sizeOfString(font: UIFont.systemFont(ofSize: 15))
            
            successText.zPosition = 110
            successText.alpha = 1
            successText.frame.size = textSize
            successText.frame.size.width += 2
            successText.position.y += 1
            successText.position = successBox.position
            view.addSubnode(successText)
        }
        
        if successType == "Reported" {
            successBox.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            successBox.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 60, y: UIScreen.main.bounds.height / 2 - 65, width: 120, height: 40)
            successBox.cornerRadius = 10
            successBox.zPosition = 100
            successBox.alpha = 1
            view.addSubnode(successBox)
            
            successText.attributedText = NSAttributedString(string: "Reported", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
            let textSize = successText.sizeOfString(font: UIFont.systemFont(ofSize: 15))
            
            successText.zPosition = 110
            successText.alpha = 1
            successText.frame.size = textSize
            successText.frame.size.width += 2
            successText.position.y += 1
            successText.position = successBox.position
            view.addSubnode(successText)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [self] in
            successBox.fadeOut()
            successText.fadeOut()
            
            successBox.alpha = 0
            successText.alpha = 0
        }
    }
    
    @objc func playPause() {
<<<<<<< Updated upstream
        if !isPLaying {
            print("playing here")
            audioPlayer.start()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "animateIcon"), object: nil)
            isPLaying = true
        } else {
            print("not playing here")
            audioPlayer.pause()
            isPLaying = false
        }
    }
    
    @objc func didFinishPlaying(notification: Notification) {
        let stoppedPlayerItem: AVPlayerItem = notification.object as! AVPlayerItem
        stoppedPlayerItem.seek(to: CMTime.zero) { (result) in
            if result {
                print("Successfully restarted song.")
                self.audioPlayer.start()
=======
        if fullSongOpen == false {
            if isPlayingSong == false {
                audioPlayer.playClip()
                NotificationCenter.default.post(name: NSNotification.Name("notPaused"), object: nil)
                playButton.playPauseFadeOut()
            }
            
            else {
                NotificationCenter.default.post(name: Notification.Name("isPaused"), object: nil)
                pauseButton.playPauseFadeOut()
                audioPlayer.pauseClip()
            }
        }
        else {
            if isPlayingSong == false {
                audioPlayer.homePlayFullSong()
                playButton.playPauseFadeOut()
            }
            else {
                pauseButton.playPauseFadeOut()
                audioPlayer.homePlayPauseSong()
>>>>>>> Stashed changes
            }
        }
    }
}

extension ASImageNode {
    func fadeOut() {
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.8
        fadeOut.toValue = 0
        fadeOut.duration = 1.5
        fadeOut.autoreverses = false
        self.layer.add(fadeOut, forKey: "opacity")
    }
}

extension ASTextNode {
    func fadeOut() {
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        fadeOut.duration = 1.5
        fadeOut.autoreverses = false
        self.layer.add(fadeOut, forKey: "opacity")
    }
}

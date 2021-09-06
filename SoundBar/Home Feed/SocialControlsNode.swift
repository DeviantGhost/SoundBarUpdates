//
//  SocialControlsNode.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-05.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation

var fullSongOpen = false

var popUpHeight: CGFloat!
var popUpPosition: CGFloat!

var titleOneGlobal = ""
var titleTwoGlobal = ""
var contentImageGlobal = ""

class SocialControlsNode: BaseNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var completesCircle = CGFloat(Double.pi * 2)
    var newsRotationAngle = 0.0
    var springsLoadAngle = 0.0
    
    let songDiskPulse = CAShapeLayer()
    let songDiskBox = ASImageNode()
    let fullSongRectangle = ASImageNode()
    let songProgressBar = ASImageNode()
    let songProgressBarCurrent = ASImageNode()
    var songTimeAnimationDuration = 0.0
    
    let likeButton = ASButtonNode()
    let commentButton = ASButtonNode()
    let shareButton = ASButtonNode()
    let repostButton = ASImageNode()
    let playFullAudioButton = ASButtonNode()
    var playFullAudioButtonBox = ASImageNode()
    let backgroundImage = ASImageNode()
    
    let likeCount = ASTextNode()
    let shareCount = ASTextNode()
    let commentCount = ASTextNode()
<<<<<<< Updated upstream

    init(likes: String, shares: String, comments: String) {
        super.init()
        setupNodes(likes: likes, shares: shares, comments: comments)
=======
    let repostText = ASTextNode()
    
    var likeCountBox = ASImageNode()
    var shareCountBox = ASImageNode()
    var commentCountBox = ASImageNode()
    let repostBox = ASImageNode()
    
    let songDisk = ASImageNode()
    var centerOffset = 0
    let nameOfArtist = ASTextNode()
    let nameOfSong = ASTextNode()
    
    let nameOfArtistBox = ASImageNode()
    let nameOfSongBox = ASImageNode()
    
    var darkBackground = ASImageNode()
    
    var timer: Timer?
    let nc = NotificationCenter.default
    
    var songID: String?
    var imageLink: String?
    
    var audioPlayer: AudioHandler!
    var animationHandler: HomeAnimationHandler!
    
    var backgroundImageNode: BackgroundImageNode!

    var songMore: SongPresentation!
    
    var clickedProfile: ProfileHeader?
    
    init(likes: String, shares: String, comments: String, artistID: String, songName: String, imageLink: String, id: String, fullLink: String, snippetLink: String, audio: AudioHandler, homeAnimationHandler: HomeAnimationHandler, song: SongPresentation, artworkLink: String?, space: Double) {
        super.init()
        
        self.songID = id
        songMore = song
        
        backgroundImageNode = BackgroundImageNode(space: Double(tabBarHeight), artworkLink: artworkLink, audio: audio)
        audioPlayer = audio
        animationHandler = homeAnimationHandler
        isPlaying = true
        setupNodes(likes: likes, shares: shares, comments: comments, artistID: artistID, songName: songName, imageLink: imageLink, id: id, fullLink: fullLink, snippetLink: snippetLink)
>>>>>>> Stashed changes
    }
    
    override func didExitVisibleState() {
        fullSongOpen = false
        animationHandler.resetRotateButton()
        print(animationHandler.isPaused)
    }
    
    override func didEnterVisibleState() {
        fullSongReset()
        setAnimationHandlerObjects()
        animationHandler.setToClean(false)
        
        animationHandler.pulseDisk()
        animationHandler.pulseDiskFadeOut()
        animationHandler.rotateDisk(completeCircle: completesCircle)
        animationHandler.isPaused = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(songPause), name: Notification.Name("isPaused"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(songPlay), name: Notification.Name("notPaused"), object: nil)
    }
    
    func startRotatingAnimations() {
        animationHandler.pulseDisk()
        animationHandler.pulseDiskFadeOut()
        animationHandler.rotateDisk(completeCircle: completesCircle)
    }
    
    func setAnimationHandlerObjects() {
        animationHandler.setSongText(text: nameOfSong)
        animationHandler.setArtistText(text: nameOfArtist)
        animationHandler.setSongDisk(image: songDisk)
        animationHandler.setSongProgressBar(image: songProgressBar)
        animationHandler.setCurrentSongProgressBar(image: songProgressBarCurrent)
        animationHandler.setFullSongRectangle(image: fullSongRectangle)
        animationHandler.setSongDiskPulse(shapeLayer: songDiskPulse)
        animationHandler.setFullSongTriangle(button: playFullAudioButton)
    }
    
    private func setupNodes(likes: String, shares: String, comments: String, artistID: String, songName: String, imageLink: String, id: String, fullLink: String, snippetLink: String) {
        songDisk.image = UIImage(named: imageLink )
        songDisk.contentMode = .scaleAspectFill
        songDisk.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        songDisk.borderWidth = 1
        songDisk.cornerRadius = 50/2
        songDisk.clipsToBounds = true
        songDisk.style.preferredSize = .init(width: 50, height: 50)
        songDisk.addTarget(self, action: #selector(artistProfileClicked), forControlEvents: .touchUpInside)
        
        songDiskBox.style.preferredSize = .init(width: 70, height: 50)
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        
        nameOfArtist.attributedText = NSAttributedString(string: artistID, attributes: attributes)
        nameOfArtist.maximumNumberOfLines = 1
        nameOfArtist.zPosition = 3
        
        nameOfSong.attributedText = NSAttributedString(string: songName, attributes: attributes)
        nameOfSong.maximumNumberOfLines = 1
        nameOfSong.zPosition = 3
        
        songProgressBar.zPosition = 10
        songProgressBarCurrent.zPosition = 10

        fullSongRectangle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        fullSongRectangle.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        
        songProgressBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        songProgressBar.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 3)
        
        songProgressBarCurrent.backgroundColor = UIColor().soundbarColorScheme()
        songProgressBarCurrent.style.preferredSize = CGSize(width: 0, height: 3)
        songProgressBarCurrent.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        likeButton.setImage(UIImage(named: "SocialsLikeButton"), for: .normal)
        likeButton.setImage(UIImage(named: "SocialsLikeButtonClicked"), for: .selected)
        likeButton.zPosition = 3
        likeButton.frame.size = CGSize(width: 30, height: 30)
        likeButton.style.preferredSize = CGSize(width: 30, height: 30)
        likeButton.addTarget(self, action: #selector(likeButtonClicked), forControlEvents: .touchUpInside)
        
        likeCount.attributedText = NSAttributedString(string: likes, attributes: attributes)
        likeCount.maximumNumberOfLines = 1
        likeCount.zPosition = 2
        
        shareButton.setImage(UIImage(named: "SocialsShareButton"), for: .normal)
        shareButton.setImage(UIImage(named: "SocialsShareButtonClicked"), for: .selected)
        shareButton.style.preferredSize = .init(width: 30, height: 30)
        shareButton.addTarget(self, action: #selector(shareButtonClicked), forControlEvents: .touchUpInside)
        shareButton.zPosition = 2
        
        repostButton.image = UIImage(named: "RepostButton")
        repostButton.style.preferredSize = CGSize(width: 40, height: 40)
        repostButton.addTarget(self, action: #selector(repostClicked), forControlEvents: .touchUpInside)
        
        repostText.attributedText = NSAttributedString(string: "Repost", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        repostBox.style.preferredSize = .init(width: 75, height: 15)
        
        shareCount.attributedText = NSAttributedString(string: shares, attributes: attributes)
        shareCount.maximumNumberOfLines = 1
        shareCount.zPosition = 2
        
        commentButton.setImage(UIImage(named: "SocialsCommentButton"), for: .normal)
        commentButton.setImage(UIImage(named: "SocialsCommentButtonClicked"), for: .selected)
        commentButton.style.preferredSize = .init(width: 30, height: 30)
        commentButton.addTarget(self, action: #selector(commentButtonClicked), forControlEvents: .touchUpInside)
        commentButton.zPosition = 2
        
        commentCount.attributedText = NSAttributedString(string: comments, attributes: attributes)
        commentCount.maximumNumberOfLines = 1
        commentCount.zPosition = 2
        
        likeCountBox.style.preferredSize = .init(width: 75, height: 15)
        shareCountBox.style.preferredSize = .init(width: 75, height: 15)
        commentCountBox.style.preferredSize = .init(width: 75, height: 15)
        
        playFullAudioButton.setImage(UIImage(named: "FullSongButton"), for: .normal)
        playFullAudioButton.style.preferredSize = .init(width: 30, height: 30)
        playFullAudioButton.addTarget(self, action: #selector(playFullAudioButtonClicked), forControlEvents: .touchUpInside)
        playFullAudioButton.zPosition = 2
        playFullAudioButtonBox.style.preferredSize = .init(width: 75, height: 50)
        
        let name = artistID.components(separatedBy: " ")
        clickedProfile = ProfileHeader(coverLink: nil, profileLink: imageLink, username: "@\(name[0].lowercased())\(name.count > 1 ? name[1].lowercased() : "")", followersCount: 48574, followingCount: 3398, likesCount: 4858, bio: "Just a young artist trying to make it big", bioLink: nil, fullName: artistID, id: nil, socials: nil, listens: 393940)
        
        nameOfArtistBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.7, height: 20)
        nameOfSongBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.7, height: 20)
    }
    
    @objc func songPause() {
        setAnimationHandlerObjects()
        animationHandler.stopRotatingDisk()
        if fullSongOpen {
            animationHandler.pauseSongProgressBar()
        }
        animationHandler.setToClean(true)
    }
    
    @objc func songPlay() {
        setAnimationHandlerObjects()
        animationHandler.continueRotatingDisk()
        animationHandler.setToClean(false)
    }
    
    @objc func likeButtonClicked() {
        if likeButton.isSelected {
            likeButton.isSelected = false
<<<<<<< Updated upstream
        } else {
            likeButton.isSelected = true
            shareButton.isSelected = false
            commentButton.isSelected = false
=======
        }
        else {
            likeButton.isSelected = true
>>>>>>> Stashed changes
        }
    }
    
    @objc func shareButtonClicked() {
        titleOneGlobal = songMore.songName ?? ""
        titleTwoGlobal = songMore.artistID ?? ""
        contentImageGlobal = songMore.imageLink ?? ""
     
        popUpHeight = (365 / UIScreen.main.bounds.height)
        popUpPosition = 1 - (365 / UIScreen.main.bounds.height)
        
        NotificationCenter.default.post(name: Notification.Name("loadSharePopUp"), object: nil)
    }
    
    @objc func commentButtonClicked() {
        popUpHeight = 0.75
        popUpPosition = 0.25
 
        NotificationCenter.default.post(name: Notification.Name("loadCommentPopUp"), object: nil)
    }
    
    @objc func repostClicked() {
        successType = "Repost"
        NotificationCenter.default.post(name: Notification.Name("success"), object: nil)
    }
    
    @objc func artistProfileClicked() {
//        artistProfile = true
//
//        let vc = AccountProfileController(audio: audioPlayer)
//        vc.hidesBottomBarWhenPushed = true
//        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func playFullAudioButtonClicked() {
        print("node: play button \(fullSongOpen)")
        setAnimationHandlerObjects()
        if fullSongOpen {
            audioPlayer.pauseCurrentSong()
            fullSongClosed()
            fullSongOpen = false
            audioPlayer.unpauseCurrentSong()
            audioPlayer.restartFull()
        } else {
<<<<<<< Updated upstream
            shareButton.isSelected = true
            commentButton.isSelected = false
            likeButton.isSelected = false
        }
    }
    
    @objc private func commentButtonClicked() {
        if commentButton.isSelected {
            commentButton.isSelected = false
        } else {
            commentButton.isSelected = true
            shareButton.isSelected = false
            likeButton.isSelected = false
=======
            audioPlayer.pauseCurrentSong()
            fullSongOpened()
            fullSongOpen = true
            audioPlayer.unpauseCurrentSong()
        }
    }
    
    func fullSongOpened() {
        print(songProgressBarCurrent)
        songProgressBar.isHidden = false
        songProgressBarCurrent.isHidden = false
        
        animationHandler.moveProgressBarUp(progressBar: "current")
        animationHandler.openFullSongTriangleButton()
        animationHandler.springRotateDisk()
        animationHandler.stopPulsingDisk()
        
        animationHandler.moveProgressBarUp(progressBar: "rectangle")
        animationHandler.moveProgressBarUp(progressBar: "notcurrent")
        
        isPlaying = true
        animationHandler.setToClean(true)
    }
    
    @objc func fullSongClosed() {
        songProgressBar.isHidden = true
        songProgressBarCurrent.isHidden = true
        
        if fullSongOpen || animationHandler.toClean {
            isPlaying = true
            
            animationHandler.pulseDisk()
            animationHandler.pulseDiskFadeOut()
            animationHandler.rotateDisk(completeCircle: CGFloat(Double.pi * 2))
            animationHandler.animateFullSongBack()
            animationHandler.closeRotateButton()

            animationHandler.pulseDisk()
            animationHandler.pulseDiskFadeOut()
            animationHandler.rotateDisk(completeCircle: completesCircle)
>>>>>>> Stashed changes
        }
    }
    
    @objc func fullSongReset() {
        songProgressBar.isHidden = true
        songProgressBarCurrent.isHidden = true
        if fullSongOpen || animationHandler.toClean {
            isPlaying = true
            
            animationHandler.pulseDisk()
            animationHandler.pulseDiskFadeOut()
            animationHandler.rotateDisk(completeCircle: CGFloat(Double.pi * 2))
            animationHandler.animateFullSongBack()
            animationHandler.resetRotateButton()

            animationHandler.pulseDisk()
            animationHandler.pulseDiskFadeOut()
            animationHandler.rotateDisk(completeCircle: completesCircle)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
        let artistNameCenter = ASCenterLayoutSpec(centeringOptions: .Y, child: nameOfArtist)
        let songNameCenter = ASCenterLayoutSpec(centeringOptions: .Y, child: nameOfSong)
        
        let artistNameOverlay = ASOverlayLayoutSpec(child: nameOfArtistBox, overlay: artistNameCenter)
        let songNameOverlay = ASOverlayLayoutSpec(child: nameOfSongBox, overlay: songNameCenter)
        
        
        let vSongInfo = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 0,
                                              justifyContent: .start,
                                              alignItems: .center,
                                              children: [artistNameOverlay, songNameOverlay])
            
        let songDiskCenter = ASStackLayoutSpec(direction: .vertical,
                                      spacing: 0,
                                      justifyContent: .start,
                                      alignItems: .center,
                                      children: [songDisk])
    
        let songDiskOverlay = ASOverlayLayoutSpec(child: songDiskBox, overlay: songDiskCenter)

    
        let hSongInfoDisplay = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: 0,
                                                     justifyContent: .start,
                                                     alignItems: .center,
                                                     children: [songDiskOverlay, vSongInfo])
        
        let fullSongAudioCenter = ASStackLayoutSpec(direction: .vertical,
                                  spacing: 0,
                                  justifyContent: .center,
                                  alignItems: .center,
                                  children: [playFullAudioButton])
        
        let fullSongButtonOverlay = ASOverlayLayoutSpec(child: playFullAudioButtonBox, overlay: fullSongAudioCenter)
        
        let likeCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: likeCount)
        let likeOverlay = ASOverlayLayoutSpec(child: likeCountBox, overlay: likeCenter)

        let shareCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: shareCount)
        let shareOverlay = ASOverlayLayoutSpec(child: shareCountBox, overlay: shareCenter)
        
        let commentCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: commentCount)
        let commentOverlay = ASOverlayLayoutSpec(child: commentCountBox, overlay: commentCenter)
        
        let repostCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: repostText)
        let repostOverlay = ASOverlayLayoutSpec(child: repostBox, overlay: repostCenter)
        
        let vLikeStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 2,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [likeButton, likeOverlay])
        
        let vShareStack = ASStackLayoutSpec(direction: .vertical,
                                                    spacing: 2,
                                                    justifyContent: .center,
                                                    alignItems: .center,
                                                    children: [shareButton, shareOverlay])
        
        let vCommentStack = ASStackLayoutSpec(direction: .vertical,
                                                      spacing: 2,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [commentButton, commentOverlay])
        
        let vRepostStack = ASStackLayoutSpec(direction: .vertical,
                                                      spacing: 2,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [repostButton, repostOverlay])
        
        let hStack = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 25,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [vLikeStack, vShareStack, vCommentStack, vRepostStack, fullSongButtonOverlay])
        
        let testSpec = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: hStack)
        
        
        let songProgressBarOverlay = ASOverlayLayoutSpec(child: songProgressBar, overlay: songProgressBarCurrent)
 
        let fullSongStack = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 0,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [songProgressBarOverlay])
 
        let fullSongStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: fullSongStack)
        
        
        let newSpec = ASStackLayoutSpec(direction: .horizontal,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .baselineLast,
                                             children: [hSongInfoDisplay, testSpec])
        
        let finalStack = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 18,
                                             justifyContent: .end,
                                             alignItems: .center,
                                             children: [newSpec, fullSongStackInset])
        
        let displayStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: -3, right: 0), child: finalStack)
        
  
        let socialControlsNode = ASOverlayLayoutSpec(child: backgroundImageNode, overlay: displayStackInset)

        return socialControlsNode
    }
    
    func getHoursMinutesSecondsFrom(seconds: Double) -> (hours: Int, minutes: Int, seconds: Int) {
        let secs = Int(seconds)
        let hours = secs / 3600
        let minutes = (secs % 3600) / 60
        let seconds = (secs % 3600) % 60
        return (hours, minutes, seconds)
    }
    
    func formatTimeFor(seconds: Double) -> String {
        let result = getHoursMinutesSecondsFrom(seconds: seconds)
        let hoursString = "\(result.hours)"
        var minutesString = "\(Int(result.minutes))"
        
        if minutesString.count == 1 {
            minutesString = "\(Int(result.minutes))"
        }
        
        var secondsString = "\(result.seconds)"
        
        if secondsString.count == 1 {
            secondsString = "0\(result.seconds)"
        }
        
        var time = "\(hoursString):"
        
        if result.hours >= 1 {
            time.append("\(minutesString):\(secondsString)")
        }
        
        else {
            time = "\(minutesString):\(secondsString)"
        }
        
        return time
    }
}


    

    
   

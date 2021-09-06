//
//  FullSongPageSocialControls.swift
//  SoundBar
//
//  Created by Justin Cose on 8/8/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation

class FullSongPageSocialControls: BaseNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var completesCircle = CGFloat(Double.pi * 2)
    var newsRotationAngle = 0.0
    var springsLoadAngle = 0.0
    
    let songDiskPulse = CAShapeLayer()
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
    let repostText = ASTextNode()
    
    var likeCountBox = ASImageNode()
    var shareCountBox = ASImageNode()
    var commentCountBox = ASImageNode()
    let repostBox = ASImageNode()
    
    let songDisk = ASImageNode()
    let songDiskBox = ASImageNode()
    var centerOffset = 0
    let nameOfArtist = ASTextNode()
    let nameOfSong = ASTextNode()
    
    let nameOfArtistBox = ASImageNode()
    let nameOfSongBox = ASImageNode()
    
    var timer: Timer?
    let nc = NotificationCenter.default
    
//    let firebaseHandler = FirebaseHandler()
    var songID: String?
    var imageLink: String?
    
    var audioPlayer: AudioHandler!
    var animationHandler: HomeAnimationHandler!
    var dataSource: [SongPresentation]!
    
    var backgroundImageNode: BackgroundImageNode!


    var clickedProfile: ProfileHeader?
    
    init(likes: String, shares: String, comments: String, artistID: String, songName: String, imageLink: String, id: String, fullLink: String, snippetLink: String, audio: AudioHandler, homeAnimationHandler: HomeAnimationHandler) {
        super.init()
        self.songID = id
        
//        backgroundImageNode = BackgroundImageNode(space: Double(tabBarHeight), artworkLink: imageLink, audio: audio)

        animationHandler = homeAnimationHandler
        dataSource = hotBarsDataSourceStatic
        audioPlayer = audio
        isPlaying = true
        setupNodes(likes: likes, shares: shares, comments: comments, artistID: artistID, songName: songName, imageLink: imageLink, id: id, fullLink: fullLink, snippetLink: snippetLink)
        
    }
    
    override func didExitVisibleState() {
        shareContentView = true
        fullSongOpen = false
        print(animationHandler.isPaused)
    }
    
    override func didEnterVisibleState() {
        shareContentView = false
        print("node: enter socialcontrols \(fullSongOpen)")
        
        createObjects()
        fullSongClosed()
        setAnimationHandlerObjects()
        animationHandler.setToClean(false)
        
        animationHandler.pulseDisk()
        animationHandler.pulseDiskFadeOut()
        animationHandler.rotateDisk(completeCircle: completesCircle)
        animationHandler.isPaused = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(songPause), name: Notification.Name("isPaused"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(songPlay), name: Notification.Name("notPaused"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fullSongControlsClose), name: Notification.Name("fullSongControlsClose"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fullSongControlsOpen), name: Notification.Name("fullSongControlsOpen"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(songChanged), name: NSNotification.Name(rawValue: "updateUI"), object: nil)
        
        if isPlayingSong == true {
            animationHandler.animateSongProgressBar(progressBar: "current", duration: Double(audioPlayer.getFullPlayerItem.duration.seconds), value: audioCurrentTime?.seconds ?? 0)
        }else{
            animationHandler.animateSongProgressBar(progressBar: "current", duration: Double(audioPlayer.getFullPlayerItem.duration.seconds), value: audioCurrentTime?.seconds ?? 0)
        }
        
        fullSongOpened()
    }
    
    func startRotatingAnimations() {
        animationHandler.pulseDisk()
        animationHandler.pulseDiskFadeOut()
        animationHandler.rotateDisk(completeCircle: completesCircle)
    }
    
    @objc func songChanged(){
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        
        songDisk.image = UIImage(named: artistPFPGlobal)

        nameOfArtist.attributedText = NSAttributedString(string: fullArtistNameGlobal, attributes: attributes)
        
        
        nameOfSong.attributedText = NSAttributedString(string: fullSongNameGlobal, attributes: attributes)
        
    }
    
    func createObjects() {
        let circlePath = UIBezierPath(arcCenter: CGPoint.zero, radius: 25 , startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        songDiskPulse.path = circlePath.cgPath
        songDiskPulse.position = CGPoint(x: 35, y: 25)
        songDiskPulse.fillColor = UIColor.clear.cgColor
        songDiskPulse.strokeColor = UIColor.white.cgColor
        songDiskPulse.lineWidth = 1.0
        songDiskPulse.anchorPoint = CGPoint(x: 0.5, y: 0.5)
       // view.layer.addSublayer(songDiskPulse)
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
        //songDisk.url = URL(string: imageLink ?? "")
        songDisk.image = UIImage(named: artistPFPGlobal)
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

//        backgroundImage.backgroundColor = UIColor(white: 0, alpha: 0)
//        backgroundImage.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
//        backgroundImage.zPosition = 2
        
        fullSongRectangle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        fullSongRectangle.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        
        songProgressBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        songProgressBar.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 3)
        
        songProgressBarCurrent.backgroundColor = UIColor().soundbarColorScheme()
        
        let currentTime = CGFloat(audioCurrentTime?.value ?? 0)
        var initialBound = CGSize(width: 0, height: 3)

        print("Start Position: \(currentTime)")

        if currentTime < 0{
            initialBound = CGSize(width: 0, height: 3)
        } else {
            let currentXPixel = ((Double(currentTime) / (audioDurationGlobal ?? 0)) * Double(UIScreen.main.bounds.width))
            initialBound = CGSize(width: ceil(currentXPixel), height: 3)
            print("thinggy: \(initialBound)")

        }

        songProgressBarCurrent.style.preferredSize = initialBound
        
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
        
        
        
        
        repostText.attributedText = NSAttributedString(string: "Repost", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        repostBox.style.preferredSize = .init(width: 85, height: 50)
        
        
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
        
        repostButton.image = UIImage(named: "FullSongPageMusicControls")
        repostButton.style.preferredSize = CGSize(width: 85, height: 50)
        repostButton.addTarget(self, action: #selector(repostClicked), forControlEvents: .touchUpInside)
        
        
        let name = artistID.components(separatedBy: " ")
        clickedProfile = ProfileHeader(coverLink: nil, profileLink: imageLink, username: "@\(name[0].lowercased())\(name.count > 1 ? name[1].lowercased() : "")", followersCount: 48574, followingCount: 3398, likesCount: 4858, bio: "Just a young artist trying to make it big", bioLink: nil, fullName: artistID, id: nil, socials: nil, listens: 393940)
        
        backgroundImage.backgroundColor = UIColor(white: 0, alpha: 1)
        backgroundImage.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        backgroundImage.zPosition = 2
        backgroundImage.alpha = 0.35
        
        nameOfArtistBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.7, height: 20)
        nameOfSongBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.7, height: 20)
//        nameOfSong.backgroundColo
    }
    
    @objc func songPause() {
        setAnimationHandlerObjects()
        animationHandler.stopRotatingDisk()
        if fullSongOpen {
            animationHandler.pauseSongProgressBar()
        }
        animationHandler.setToClean(true)
        //songDiskPulse.stopPulse()
        
    }
    
    @objc func songPlay() {
        setAnimationHandlerObjects()
        animationHandler.continueRotatingDisk()
        animationHandler.setToClean(false)
    }
    
    @objc func likeButtonClicked() {
        print(hotBarsDataSourceStatic.count)
        if likeButton.isSelected {
            
            likeButton.isSelected = false
            //firebaseHandler.likeSong(songID: songID ?? "0", increaseLike: false)
        } else {
            likeButton.isSelected = true
            shareButton.isSelected = false
            commentButton.isSelected = false
            //firebaseHandler.likeSong(songID: songID!, increaseLike: true)
        }
    //    self.closestViewController?.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func messages() {
        
    }
    
    @objc func shareButtonClicked() {
        
        popUpHeight = (365 / UIScreen.main.bounds.height)
        popUpPosition = 1 - (365 / UIScreen.main.bounds.height)
        
        NotificationCenter.default.post(name: Notification.Name("loadSharePopUp"), object: nil)
//        if shareButton.isSelected {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cancelSharePopUp"), object: nil)
//        } else {
//            NotificationCenter.default.post(name: Notification.Name("loadSharePopUp"), object: nil)
//        }
        commentButton.isSelected = false
        likeButton.isSelected = false
        //firebaseHandler.shareSong(songID: songID!)
    }
    
    @objc func commentButtonClicked() {
        
        popUpHeight = 0.75
        popUpPosition = 0.25
 
        NotificationCenter.default.post(name: Notification.Name("loadCommentPopUp"), object: nil)
//        if commentButton.isSelected {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cancelCommentPopUp"), object: nil)
//        } else {
//            NotificationCenter.default.post(name: Notification.Name("loadCommentPopUp"), object: nil)
//        }
        shareButton.isSelected = false
        likeButton.isSelected = false
        //firebaseHandler.commentSong(songID: songID!, increaseComment: true)
    }
    
    @objc func repostClicked() {
        //successType = "Repost"
        print("repost clicked")

        NotificationCenter.default.post(name: Notification.Name("loadQueuePage"), object: nil)
        
        repostButton.removeTarget(self, action: #selector(repostClicked), forControlEvents: .touchUpInside)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.repostButton.addTarget(self, action: #selector(self.repostClicked), forControlEvents: .touchUpInside)
        }

            

    }
    
    @objc func artistProfileClicked() {

  //      self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer), animated: true)

     
    }
    
    @objc func fullSongControlsClose(){
        likeButton.queuePageOpened(queueButtonY: Double(repostButton.position.y))
        likeCount.queuePageOpened(queueButtonY: Double(repostButton.position.y))
        
        commentCount.queuePageOpened(queueButtonY: Double(repostButton.position.y))
        commentButton.queuePageOpened(queueButtonY: Double(repostButton.position.y))
        
        shareCount.queuePageOpened(queueButtonY: Double(repostButton.position.y))
        shareButton.queuePageOpened(queueButtonY: Double(repostButton.position.y))
        
        
    }
    
    @objc func fullSongControlsOpen(){
        
        likeButton.queuePageClosed(queueButtonY: Double(repostButton.position.y))
        likeCount.queuePageClosed(queueButtonY: Double(repostButton.position.y))
        
        commentCount.queuePageClosed(queueButtonY: Double(repostButton.position.y))
        commentButton.queuePageClosed(queueButtonY: Double(repostButton.position.y))
        
        shareCount.queuePageClosed(queueButtonY: Double(repostButton.position.y))
        shareButton.queuePageClosed(queueButtonY: Double(repostButton.position.y))
        
        
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
        
        print("FullSongPage Duration: \(self.audioPlayer.getFullPlayerItem.duration.value)")
        
        
        
        animationHandler.moveProgressBarUp(progressBar: "current")
        animationHandler.openFullSongTriangleButton()
//        animationHandler.springRotateDisk()
//        animationHandler.stopPulsingDisk()
        
        animationHandler.moveTextUp(string: "artist")
        animationHandler.moveTextUp(string: "song")
        
//        animationHandler.moveDiskUp()
//        animationHandler.moveUpDiskAnimation()
//
        animationHandler.moveProgressBarUp(progressBar: "rectangle")
        animationHandler.moveProgressBarUp(progressBar: "notcurrent")
        
        animationHandler.setToClean(true)
        print("SongProgress Size: \(songProgressBarCurrent.style.preferredSize)")

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
            
            animationHandler.pulseDisk()
            animationHandler.pulseDiskFadeOut()
            animationHandler.rotateDisk(completeCircle: completesCircle)
            
            //NotificationCenter.default.post(name: NSNotification.Name("stopTrackSong"), object: nil)
            //self.songProgressView.view.removeFromSuperview()
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
        
               // let playFullAudioButtonInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 10), child: playFullAudioButton)
        
        
        
        
            let fullSongAudioCenter = ASStackLayoutSpec(direction: .vertical,
                                  spacing: 0,
                                  justifyContent: .center,
                                  alignItems: .center,
                                  children: [playFullAudioButton])
        
           
        
            let bottomSpec = ASStackLayoutSpec(direction: .horizontal,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .center,
                                             children: [hSongInfoDisplay])
        
        
        let likeCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: likeCount)
        let likeOverlay = ASOverlayLayoutSpec(child: likeCountBox, overlay: likeCenter)

        let shareCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: shareCount)
        let shareOverlay = ASOverlayLayoutSpec(child: shareCountBox, overlay: shareCenter)
        
        let commentCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: commentCount)
        let commentOverlay = ASOverlayLayoutSpec(child: commentCountBox, overlay: commentCenter)
        
        let repostCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: repostButton)
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
                                                      children: [repostOverlay])
        
       
        
                let hStack = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 25,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [vLikeStack, vShareStack, vCommentStack, vRepostStack])
        
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
        
        
        
        
//                let displayStack = ASStackLayoutSpec(direction: .vertical,
//                                                     spacing: 20,
//                                                     justifyContent: .center,
//                                                     alignItems: .center,
//                                                     children: [testSpec, bottomSpec])
        
                let finalStack = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 18,
                                             justifyContent: .end,
                                             alignItems: .center,
                                             children: [newSpec, fullSongStackInset])
        
                let displayStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: -3, right: 0), child: finalStack)
        
      //  let homeFeedUI = ASOverlayLayoutSpec(child: backgroundImageNode, overlay: darkBackground)
  
//        let socialControlsNode = ASOverlayLayoutSpec(child: backgroundImageNode, overlay: displayStackInset)
        
        
        return displayStackInset
        
        
        
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

extension ASButtonNode{
    
    func queuePageOpened(queueButtonY: Double){
        
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = queueButtonY
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = 0.2
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")

    }
    
    func queuePageClosed(queueButtonY: Double){
        
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = queueButtonY
        move.toValue = initialPosition
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.0
        fadeOut.toValue = 1.0
        fadeOut.duration = 0.5
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(move, forKey: "position.y")
        self.layer.add(fadeOut, forKey: "opacity")
    }
}

extension ASTextNode{
    
    func queuePageOpened(queueButtonY: Double){
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = queueButtonY
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = 0.2
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(move, forKey: "position.y")
        self.layer.add(fadeOut, forKey: "opacity")
    }
    
    func queuePageClosed(queueButtonY: Double){
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        
        let move = CASpringAnimation(keyPath: "position.y")
        let initialPosition = self.position.y

        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = queueButtonY
        move.toValue = initialPosition
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        fadeOut.fromValue = 0.0
        fadeOut.toValue = 1.0
        fadeOut.duration = 0.5
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(move, forKey: "position.y")
        self.layer.add(fadeOut, forKey: "opacity")
    }
}

//
//  OnFireCell.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var currentObj: CAShapeLayer? = nil
var firstSongClicked = false
var previewAlreadyPlaying = false

class OnFireCell: BaseCellNode {
    
    let songImage = ASImageNode()
    var songImageShadeNode = ASImageNode()
    
    var topSong: SongPresentation!
    
    let previewBackgroundCircle = ASImageNode()
    let fireIcon = ASImageNode()
    var songCircle = CAShapeLayer()
    
    let artistName = ASTextNode()
    let songName = ASTextNode()
    
    var circlePath = UIBezierPath()
    
    var circleAnimating = false
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    init(topHits: SongPresentation, audio: AudioHandler, animationHandle: SongsAnimationHandler) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopSongPreview), name: NSNotification.Name("stopSongPreview"), object: nil)
        
        audioPlayer = audio
        animationHandler = animationHandle
        topSong = topHits
        
        if (!bottomSongDisplayLoaded) {
            globalAudioPlayer = audio
        }
        
        setupNodes()
    }

    override func didEnterVisibleState() {
        circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 32.5, startAngle: CGFloat(-Double.pi / 2.0), endAngle: CGFloat(Double.pi * 2.0) + CGFloat(-Double.pi / 2.0), clockwise: true)
        
        songCircle = CAShapeLayer()
        songCircle.path = circlePath.cgPath
        songCircle.fillColor = UIColor.clear.cgColor
        songCircle.strokeColor = UIColor.white.cgColor
        songCircle.lineWidth = 2.0
        songCircle.strokeEnd = 0.0
        songCircle.position = CGPoint(x: previewBackgroundCircle.position.x, y: previewBackgroundCircle.position.y)
        view.layer.addSublayer(songCircle)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let vStackListen = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .center,
                                             children: [fireIcon])
        let vStackListenCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackListen)
        let listenOverlay = ASOverlayLayoutSpec(child: previewBackgroundCircle, overlay: vStackListenCenter)
        let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenOverlay)
        let listenBoxCenterInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: listenBoxCenter)
        
        let songImageShadeNodeCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: songImageShadeNode)
        let collectionCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: songImage)
        let collectionOverlay = ASOverlayLayoutSpec(child: collectionCenter, overlay: songImageShadeNodeCenter)
        
        let spec = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: collectionOverlay)
        let layout = ASOverlayLayoutSpec(child: spec, overlay: listenBoxCenterInset)
        
        let textStackInset = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 3,
                                               justifyContent: .center,
                                               alignItems: .baselineFirst,
                                               children: [artistName, songName])
        let textInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: textStackInset)
        
        let fullLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 5,
                                           justifyContent: .center,
                                           alignItems: .baselineFirst,
                                           children: [layout, textInset])
        
        return fullLayout
    }
    
    private func setupNodes() {
        songImage.image = UIImage(named: topSong.imageLink!)
        songImage.style.preferredSize = .init(width: 200, height: 250)
        songImage.cornerRadius = 10
        songImage.addTarget(self, action: #selector(onFireSongClicked), forControlEvents: .touchUpInside)
    
        songImageShadeNode.style.preferredSize = .init(width: 200, height: 250)
        songImageShadeNode.cornerRadius = 10
        songImageShadeNode.backgroundColor = .black
        songImageShadeNode.alpha = 0.0
        
        previewBackgroundCircle.style.preferredSize = .init(width: 65, height: 65)
        previewBackgroundCircle.cornerRadius = 65/2
        previewBackgroundCircle.backgroundColor = .init(white: 0.0, alpha: 0.7)
        previewBackgroundCircle.addTarget(self, action: #selector(songPreview), forControlEvents: .touchUpInside)
        
        fireIcon.style.preferredSize = .init(width: 40, height: 40)
        fireIcon.image = .init(imageLiteralResourceName: "FireIcon")

        artistName.attributedText = NSAttributedString(string: "\((topSong.artistID ?? ""))", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        artistName.maximumNumberOfLines = 1
        
        songName.attributedText = NSAttributedString(string: "\((topSong.songName ?? ""))", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        songName.maximumNumberOfLines = 1
    }
    
    @objc func onFireSongClicked() {
        if bottomSongDisplayLoaded == true{
            songBoxDisplaying = true

        }
        
        fullSongOpen = true
        
        fullSongPageData = topSong
        fullSongImageGlobal = topSong.imageLink ?? ""
        artistPFPGlobal = topSong.profileImageLink ?? ""
        fullSongNameGlobal = topSong.songName ?? ""
        fullArtistNameGlobal = topSong.artistID ?? ""
        fullSongLinkGlobal = topSong.fullLink ?? ""

        globalAudioPlayer?.setFullAudioLink(fullLink: topSong.fullLink!)
        globalAudioPlayer?.setSnippetAudioLink(snippetLink: topSong.snippetLink!)
        globalAudioPlayer?.playFullSong()

        audioDurationGlobal = globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds
        
        NotificationCenter.default.post(name: Notification.Name("pauseIcon"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("switchBottomSongDisplayData"), object: nil, userInfo: ["data" : "onFire"])
        NotificationCenter.default.post(name: NSNotification.Name("setSongNameAndImage"), object: nil, userInfo: ["name": topSong.songName ?? "", "image": topSong.imageLink ?? ""])

        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)

        }
        
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayer"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayAnimation"), object: nil)
        
        currentObj != nil ? animationHandler.completeCircleAnimation(shapeLayer: currentObj!) : nil
 
        if previewAlreadyPlaying {
            NotificationCenter.default.post(name: Notification.Name("stopSongPreview"), object: nil)

        }
    }
    
    @objc func songPreview(){
        fullSongOpen = false
        
        animationHandler.setSongCircle(shapeLayer: songCircle)
        animationHandler.setFireIcon(image: fireIcon)

        audioCurrentTime = CMTime(seconds: globalAudioPlayer?.getCurrentTime() ?? 0, preferredTimescale: 1)
        
        if previewAlreadyPlaying == false {
            if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
                audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
            }else{
                audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
            }
        }
        
        let tempCurrentTime = CGFloat(audioCurrentTime?.value ?? 0)
        let tempDurationTime = CGFloat(globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
        let progressRation = tempCurrentTime / tempDurationTime

        globalSongDisplayNode?.animationHandler.pauseSongProgressBar(size: CGSize(width: CGFloat(progressRation * UIScreen.main.bounds.width), height: 3))
        audioDurationGlobal = Double(tempDurationTime)
        
        globalAudioPlayer?.pauseFullSong()

        audioPlayer.setSnippetAudioLink(snippetLink: topSong.snippetLink ?? "")

        if currentObj == nil {
            currentObj = songCircle
        }
        
        if currentObj == songCircle {
            if previewAlreadyPlaying {
                previewAlreadyPlaying = false
                audioPlayer.pauseClip()
                animationHandler.springRotateFireDisk()
                animationHandler.removeCircleAnimations()
                
            }
            else {
                NotificationCenter.default.post(name: Notification.Name("stopSongPreview"), object: nil)
                animationHandler.springRotateFireDisk()
                animationHandler.animateCircle()
                audioPlayer.playClip()
                NotificationCenter.default.post(name: Notification.Name("playIcon"), object: nil)
                previewAlreadyPlaying = true
            }
        }
        else {
            audioPlayer.playClip()
            NotificationCenter.default.post(name: Notification.Name("playIcon"), object: nil)
            previewAlreadyPlaying = true
            
            animationHandler.removeCircleAnimations(shapeLayer: currentObj!)
            animationHandler.springRotateFireDisk()
            animationHandler.animateCircle()
            
            currentObj = songCircle
            isPlayingSong = true
        }
    }
    
    @objc func stopSongPreview(){
        if previewAlreadyPlaying == true {
            audioPlayer.pauseClip()
            animationHandler.springRotateFireDisk()
            animationHandler.removeCircleAnimations()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

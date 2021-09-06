//
//  CellData.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-07-31.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var movedTime = "0:00"
var movedTimeSeconds = CGFloat(0.0)
var CMmovedTime = CMTime(value: Int64(0.0), timescale: 1)
var isMoving = false

class CellData: BaseCellNode {
    
    var backgroundImageNode: BackgroundImageNode!
    var socialControlsNode: SocialControlsNode!
<<<<<<< Updated upstream
    
    var spaceAbove: CGFloat!
=======

>>>>>>> Stashed changes
    var songArt: SongPresentation?
    var audioPlayer: AudioHandler?
    var animationHandler: HomeAnimationHandler!
    
<<<<<<< Updated upstream
    init(space: CGFloat? = 60, song: SongPresentation?, backgroundImageSpace: CGFloat?) {
        super.init()
        spaceAbove = space
        songArt = song
        backgroundImageNode = BackgroundImageNode(space: backgroundImageSpace, artworkLink: songArt?.imageLink)
        headerNode = HeaderNode()
        footerNode = FooterNode(artist: song?.artist ?? "", caption: song?.songCaption ?? "", listens: "\(song?.listens?.count)" ?? "0", shares: "\(song?.shares?.count)" ?? "0")
        socialControlsNode = SocialControlsNode(likes: "\(song?.likes?.count)" ?? "0", shares: "\(song?.shares?.count)" ?? "0", comments: "\(song?.comments?.count)" ?? "0")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let headerInset = ASInsetLayoutSpec(insets: .init(top: spaceAbove, left: 12, bottom: CGFloat.infinity, right: 0), child: headerNode)
        headerInset.style.flexGrow = 1

        let footerInset = ASInsetLayoutSpec(insets: .init(top: CGFloat.infinity, left: 0, bottom: 81, right: 0), child: footerNode)

        let socialNodeInset = ASInsetLayoutSpec(insets: .init(top: CGFloat.infinity, left: 0, bottom: 0, right: 0), child: socialControlsNode)
        let footerOverlay = ASOverlayLayoutSpec(child: socialNodeInset, overlay: footerInset)
        
        let topOverlay = ASOverlayLayoutSpec(child: backgroundImageNode, overlay: headerInset)
        let bottomOverlay = ASOverlayLayoutSpec(child: topOverlay, overlay: footerOverlay)
        return bottomOverlay
    }
}
=======
    init(song: SongPresentation?, backgroundImageSpace: Double, following: Bool, hotBars: Bool, audio: AudioHandler, homeAnimationHandler: HomeAnimationHandler) {
        super.init()
        
        let shares = formatNumber(song?.shares ?? 0)
        let likes = formatNumber(song?.likes ?? 0)
        let comments = formatNumber(song?.comments ?? 0)
        
        audioPlayer = audio
        animationHandler = homeAnimationHandler
        songArt = song
        
        backgroundImageNode = BackgroundImageNode(space: backgroundImageSpace, artworkLink: songArt?.imageLink, audio: audio)
                
        socialControlsNode = SocialControlsNode(likes: likes, shares: shares, comments: comments, artistID: song?.artistID ?? "", songName: song?.songName ?? "", imageLink: song?.profileImageLink ?? "", id: song?.id ?? "", fullLink: song?.fullLink ?? "", snippetLink: song?.snippetLink ?? "", audio: audio, homeAnimationHandler: animationHandler, song: song ?? SongPresentation(), artworkLink: songArt?.imageLink, space: backgroundImageSpace)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let everythingStack = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 0,
                                                justifyContent: .end,
                                                alignItems: .center,
                                                children: [socialControlsNode])
        
        return everythingStack
    }
}

func formatNumber(_ n: Int) -> String {
    let num = abs(Double(n))
    let sign = (n < 0) ? "-" : ""
    
    switch num {
    case 1_000_000_000...:
        var formatted = num / 1_000_000_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted.clean)B"
        
    case 1_000_000...:
        var formatted = num / 1_000_000
        formatted = formatted.reduceScale(to: 1)
        
        return "\(sign)\(formatted.clean)M"
        
    case 1_000...:
        var formatted = num / 1_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted.clean)K"
        
    case 0...:
        return "\(n)"
        
    default:
        return "\(sign)\(n)"
    }
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
>>>>>>> Stashed changes

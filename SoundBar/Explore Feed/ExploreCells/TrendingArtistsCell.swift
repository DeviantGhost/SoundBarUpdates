//
//  TrendingArtistsCell.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TrendingArtistsCell: BaseCellNode {
    
    let artistImage = ASImageNode()
    var artistImageShadeNode = ASImageNode()
    
    var topSong: SongPresentation!
    
    let artistName = ASTextNode()
    let songName = ASTextNode()
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    var user = ProfileHeader()
    
    init(audio: AudioHandler, animationHandle: SongsAnimationHandler, useInfo: ProfileHeader) {
        super.init()

        audioPlayer = audio
        animationHandler = animationHandle
        user = useInfo
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let artistImageShadeNodeCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: artistImageShadeNode)
        let imageCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: artistImage)
        let imageOverlay = ASOverlayLayoutSpec(child: imageCenter, overlay: artistImageShadeNodeCenter)
        
        let spec = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: imageOverlay)
        
        let textStackInset = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 3,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [artistName, songName])
        let textInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: textStackInset)
        
        let fullLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 5,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [spec, textInset])
        
        return fullLayout
    }
    
    private func setupNodes() {
        artistImage.image = UIImage(named: user.profileLink!)
        artistImage.style.preferredSize = .init(width: 200, height: 200)
        artistImage.cornerRadius = 200/2
        artistImage.addTarget(self, action: #selector(trendingArtistClicked), forControlEvents: .touchUpInside)
        
        artistImageShadeNode.style.preferredSize = .init(width: 200, height: 250)
        artistImageShadeNode.cornerRadius = 10
        artistImageShadeNode.backgroundColor = .black
        artistImageShadeNode.alpha = 0.0
        
        artistName.attributedText = NSAttributedString(string:user.fullName!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        artistName.maximumNumberOfLines = 1
        
        songName.attributedText = NSAttributedString(string: user.username!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        
        songName.maximumNumberOfLines = 1
    }
    
    @objc func trendingArtistClicked() {
        artistProfile = true
        self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer, data: user), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

//
//  FullSongPageTop.swift
//  SoundBar
//
//  Created by Justin Cose on 8/9/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class FullSongPageTop: BaseCellNode {
    
    var backCircle = ASImageNode()
    var settingsCircle = ASImageNode()
    
    var backIcon = ASImageNode()
    var settingsIcon = ASImageNode()

    override init() {
        super.init()
        
        setupNodes()
    }
   
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let backOverlay = ASOverlayLayoutSpec(child: backCircle, overlay: backIcon)
        let settingsOverlay = ASOverlayLayoutSpec(child: settingsCircle, overlay: settingsIcon)
        
        let topButtons = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: UIScreen.main.bounds.width / 1.5,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [backOverlay, settingsOverlay])
        
        let topStack = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: topButtons)

        return topStack
    }
    
    func setupNodes() {
        backIcon.image = UIImage(named: "DownArrowPopUp")
        backIcon.style.preferredSize = .init(width: 30, height: 30)
        backIcon.contentMode = .scaleAspectFill
        
        backCircle.style.preferredSize = CGSize(width: 30, height: 30)
        backCircle.cornerRadius = 30/2
        backCircle.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.5)
        backCircle.addTarget(self, action: #selector(backClicked), forControlEvents: .touchUpInside)

        settingsIcon.style.preferredSize = .init(width: 30, height: 30)
        settingsIcon.contentMode = .scaleAspectFill
        
        settingsCircle.style.preferredSize = CGSize(width: 30, height: 30)
        settingsCircle.cornerRadius = 30/2
    }
  
    @objc private func backClicked() {
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }
        
        else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }
    
        globalSongDisplayNode?.animationHandler.animateSongProgressBar(progressBar: "current", duration: globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
        self.closestViewController?.dismiss(animated: true, completion: nil)
    }
}


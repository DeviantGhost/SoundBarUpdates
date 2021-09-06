//
//  PlaylistCellData.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-23.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class PlaylistCellData: BaseCellNode {
    var playlistData: Any?
    var isFavorites: Bool!
    var isRecommended: Bool!
    
    let playlistImage = ASNetworkImageNode()
    let textNode = ASTextNode()
    let backgroundImageNode = ASImageNode()
    let moreButtonNode = ASButtonNode()
    let listensNode = ASImageNode()
    let listenCount = ASTextNode()
    let headphonesImage = ASImageNode()
    
    init(data: Any, type: Bool, recommended: Bool = false) {
        super.init()
        playlistData = data
        isFavorites = type
        isRecommended = recommended
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if !isFavorites {
            let imageInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: playlistImage)
            let textInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: textNode)
            textInset.style.flexGrow = 1
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 5,
                                     justifyContent: .start,
                                     alignItems: .stretch,
                                     children: [imageInset, textInset])
        } else {
            let hBackgroundStack = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: 0,
                                                     justifyContent: .center,
                                                     alignItems: .stretch,
                                                     children: [backgroundImageNode])
            let textCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: textNode)
            let rightPadding = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 0,
                                                 justifyContent: .end,
                                                 alignItems: .stretch,
                                                 children: [moreButtonNode])
            let moreButtonInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: rightPadding)
            moreButtonInset.style.flexGrow = 1
            
            let vStackListen = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [headphonesImage, listenCount])
            
            let vStackListenCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackListen)
            let listenOverlay = ASOverlayLayoutSpec(child: listensNode, overlay: vStackListenCenter)
            
            let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenOverlay)
            let playlistImageOverlay = ASOverlayLayoutSpec(child: playlistImage, overlay: listenBoxCenter)
            
            let hCellStack = ASStackLayoutSpec(direction: .horizontal,
                                     spacing: 5,
                                     justifyContent: .start,
                                     alignItems: .stretch,
                                     children: [playlistImageOverlay, textCenter, moreButtonInset])
            
            return ASOverlayLayoutSpec(child: hBackgroundStack, overlay: hCellStack)
        }
    }
    
    private func setupNodes() {
        if !isFavorites {
            playlistImage.style.preferredSize = .init(width: 150, height: 150)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.url = URL(string: ((playlistData as? SongPlaylists)?.imageLink)!)
            playlistImage.cornerRadius = 3
            playlistImage.borderWidth = 1
            playlistImage.borderColor = UIColor.white.cgColor
            
            textNode.attributedText = NSAttributedString(string: ((playlistData as? SongPlaylists)?.playlistName)!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        } else {
            isRecommended ? (backgroundImageNode.backgroundColor = .black) : (backgroundImageNode.backgroundColor = .init(white: 1, alpha: 0.1))

            backgroundImageNode.style.preferredSize = .init(width: UIScreen.main.bounds.width - 15, height: 80)
            backgroundImageNode.cornerRadius = 5
            
            playlistImage.url = URL(string: ((playlistData as? UserTracks)?.imageLink)!)
            playlistImage.style.preferredSize = .init(width: 80, height: 80)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.cornerRadius = 3

            var string = ((playlistData as? UserTracks)?.songName) ?? "New Song"
            if string.count > 28 {
                let splitIndex = string.index(after: string.index(string.startIndex, offsetBy: 24))
                let newString = string[string.startIndex..<splitIndex] + "\n" + string[splitIndex..<string.endIndex]
                string = String(newString)
            }
            textNode.attributedText = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            textNode.maximumNumberOfLines = 2
            
            moreButtonNode.setImage(UIImage(named: "moreEllipsis"), for: .normal)
            moreButtonNode.addTarget(self, action: #selector(moreButtonClicked), forControlEvents: .touchUpInside)
            
            listensNode.style.preferredSize = .init(width: 50, height: 50)
            listensNode.cornerRadius = 50/2
            listensNode.backgroundColor = .init(white: 0.0, alpha: 0.7)
            listensNode.borderWidth = 1
            listensNode.borderColor = UIColor.white.cgColor
            
            headphonesImage.style.preferredSize = .init(width: 20, height: 20)
            headphonesImage.cornerRadius = 20/2
            headphonesImage.image = .init(imageLiteralResourceName: "headphones")
            
            listenCount.attributedText = NSAttributedString(string: ((playlistData as? UserTracks)?.listenCount)!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        }
    }
    
    @objc private func moreButtonClicked() {
        
    }
}

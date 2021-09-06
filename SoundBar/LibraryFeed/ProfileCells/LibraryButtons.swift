//
//  LibraryButtons.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-07-12.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var newXLocationLibraryUnderline = CGFloat()

class LibraryButtons: BaseCellNode {
    
    var playlistText = ASTextNode()
    var artistText = ASTextNode()
    var favoritesText = ASTextNode()

    var playlistBox = ASImageNode()
    var artistBox = ASImageNode()
    var favoritesBox = ASImageNode()

    var underlineNode = ASImageNode()
    
    var topPadding = ASImageNode()

    var buttonsHeight = 40.unitRatio()
    var topPaddingMeasure = 15.unitRatio()

    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(activateSearchBar), name: NSNotification.Name("activateSearchBar"), object: nil)

        self.backgroundColor = UIColor().topBackgroundGray()
        setupNodes()
    }

    func getProfileButtonsHeight() -> (CGFloat) { return  (CGFloat)(buttonsHeight + topPaddingMeasure)}

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let playlistTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: playlistText)
        let artistTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: artistText)
        let favoritesTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: favoritesText)
        
        let playlistOverlay = ASOverlayLayoutSpec(child: playlistBox, overlay: playlistTextCenter)
        let artistOverlay = ASOverlayLayoutSpec(child: artistBox, overlay: artistTextCenter)
        let favoritesOverlay = ASOverlayLayoutSpec(child: favoritesBox, overlay: favoritesTextCenter)
        
        let playlistBoxStack = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 0,
                                               justifyContent: .end,
                                               alignItems: .center,
                                               children: [playlistOverlay, underlineNode])


        let buttonsStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 0,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [playlistBoxStack, artistOverlay, favoritesOverlay])

        let centerButtonsStack = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: buttonsStack)
        
        let buttontsInset = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 0,
                                               justifyContent: .end,
                                               alignItems: .center,
                                               children: [topPadding, centerButtonsStack])

        return buttontsInset
    }

    private func setupNodes() {
        playlistBox.style.preferredSize = CGSize(width: Int(UIScreen.main.bounds.width) / 3, height: buttonsHeight)
        
        playlistText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playlistText.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)

        artistBox.style.preferredSize = CGSize(width: Int(UIScreen.main.bounds.width) / 3, height: buttonsHeight)
    
        artistText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        artistText.addTarget(self, action: #selector(artistClicked), forControlEvents: .touchUpInside)

        favoritesBox.style.preferredSize = CGSize(width: Int(UIScreen.main.bounds.width) / 3, height: buttonsHeight)
        
        favoritesText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        favoritesText.addTarget(self, action: #selector(favoritesClicked), forControlEvents: .touchUpInside)

        topPadding.style.preferredSize = CGSize(width: Int(UIScreen.main.bounds.width), height: topPaddingMeasure)
        
        if currentTab == "Playlists" {
            playlistText.attributedText = NSAttributedString(string: "Playlists", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            artistText.attributedText = NSAttributedString(string: "Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            favoritesText.attributedText = NSAttributedString(string: "Favorites", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            
            newXLocationLibraryUnderline = playlistBox.position.x
            underlineNode.position.x = newXLocationLibraryUnderline
        }
        
        if currentTab == "Artists" {
            playlistText.attributedText = NSAttributedString(string: "Playlists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            artistText.attributedText = NSAttributedString(string: "Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            favoritesText.attributedText = NSAttributedString(string: "Favorites", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            
            newXLocationLibraryUnderline = artistBox.position.x
            underlineNode.position.x = newXLocationLibraryUnderline
        }

        if currentTab == "Favorites" {
            playlistText.attributedText = NSAttributedString(string: "Playlists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            artistText.attributedText = NSAttributedString(string: "Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            favoritesText.attributedText = NSAttributedString(string: "Favorites", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            
            newXLocationLibraryUnderline = favoritesBox.position.x
            underlineNode.position.x = newXLocationLibraryUnderline
        }
        
        underlineNode.backgroundColor = UIColor().soundbarColorScheme()
        underlineNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 3, height: 1.5)
    }

    @objc func playlistClicked() {
        moreType = "Playlist"
        NotificationCenter.default.post(name: Notification.Name("playlistClicked"), object: nil)

        newXLocationLibraryUnderline = playlistBox.position.x

        underlineNode.moveBar()
        underlineNode.position.x = newXLocationLibraryUnderline

        playlistText.attributedText = NSAttributedString(string: "Playlists", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        artistText.attributedText = NSAttributedString(string: "Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        favoritesText.attributedText = NSAttributedString(string: "Favorites", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
    }

    @objc func artistClicked() {
        moreType = "Artist"
        NotificationCenter.default.post(name: Notification.Name("artistClicked"), object: nil)

        newXLocationLibraryUnderline = artistBox.position.x
        
        underlineNode.moveBar()
        underlineNode.position.x = newXLocationLibraryUnderline
        
        playlistText.attributedText = NSAttributedString(string: "Playlists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        artistText.attributedText = NSAttributedString(string: "Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        favoritesText.attributedText = NSAttributedString(string: "Favorites", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
    }

    @objc func favoritesClicked() {
        moreType = "Song"

        NotificationCenter.default.post(name: Notification.Name("favoritesClicked"), object: nil)

        newXLocationLibraryUnderline = favoritesBox.position.x

        underlineNode.moveBar()
        underlineNode.position.x = newXLocationLibraryUnderline

        playlistText.attributedText = NSAttributedString(string: "Playlists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        artistText.attributedText = NSAttributedString(string: "Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        favoritesText.attributedText = NSAttributedString(string: "Favorites", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
    }
    
    @objc func activateSearchBar() {
//        underlineNode.alpha = 0
    }
    
    @objc func clearSearchBar() {
//        underlineNode.alpha = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

extension ASImageNode {
    func moveBar() {
        let initialPosition = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = newXLocationLibraryUnderline
        move.duration = 0.175
        self.layer.add(move, forKey: "position.x")
    }
    
    func moveBarDown() {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + 70
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
    
    func moveBarUp() {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition - 70
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
}

extension ASTextNode {
    func moveTextDown() {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + 70
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
    
    func moveTextUp() {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition - 70
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
}

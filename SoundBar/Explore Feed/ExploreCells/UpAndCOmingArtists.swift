//
//  UpAndComingArtists.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-08-24.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class UpAndComingArtists: BaseCellNode {
    
    let collectionImageBackground = ASImageNode()
    var topSong: SongPresentation!
    
    var following = false
    
    var artistProfileImage = ASImageNode()
    
    let followArtistNode = ASImageNode()
    var followButton = ASImageNode()
    var followText = ASTextNode()
    
    var nameArtist = ASTextNode()
    var nameTextBox = ASImageNode()

    var usernameArtist = ASTextNode()
    var usernameTextBox = ASImageNode()
    
    var audioPlayer: AudioHandler!
    
    var artist: ProfileHeader!
    
    init(artists: ProfileHeader) {
        super.init()
        artist = artists
        setupNodes()
        
        audioPlayer = AudioHandler()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let usernameCenter = ASCenterLayoutSpec(centeringOptions: .Y, child: usernameArtist)
        let textOverlay = ASOverlayLayoutSpec(child: usernameTextBox, overlay: usernameCenter)
        
        let nameCenter = ASCenterLayoutSpec(centeringOptions: .Y, child: nameArtist)
        let nameOverlay = ASOverlayLayoutSpec(child: nameTextBox, overlay: nameCenter)
        
        let textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 5,
                                          justifyContent: .center,
                                          alignItems: .baselineFirst,
                                          children: [nameOverlay, textOverlay])
        
        let followTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: followText)
        
        let followButtonOverlay = ASOverlayLayoutSpec(child: followButton, overlay: followTextCenter)
        
        let imageTextStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 5,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [artistProfileImage, textStack])
        
        let stack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 60,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [imageTextStack, followButtonOverlay])
        
        let imageTextStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: stack)
        
        let wholeOverlay = ASOverlayLayoutSpec(child: followArtistNode, overlay: imageTextStackInset)
        
        return wholeOverlay
    }
    
    private func setupNodes() {
        followArtistNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 50)
        followArtistNode.cornerRadius = 5
        
        artistProfileImage.cornerRadius = 10
        artistProfileImage.image = UIImage(named: artist.profileLink!)
        artistProfileImage.style.preferredSize = CGSize(width: 45, height: 45)
        artistProfileImage.cornerRadius = 45/2
        //artistProfileImage.addTarget(self, action: #selector(artistClicked), forControlEvents: .touchUpInside)
        
        nameArtist.attributedText = NSAttributedString(string: artist.fullName!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        nameTextBox.style.preferredSize = CGSize(width: 160, height: 15)
        
        usernameArtist.attributedText = NSAttributedString(string: artist.username!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        usernameTextBox.style.preferredSize = CGSize(width: 160, height: 15)

        followText.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        followButton.style.preferredSize = CGSize(width: 75, height: 25)
        followButton.backgroundColor = UIColor().soundbarColorScheme()
        followButton.cornerRadius = 5
        followButton.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
    }
    
//    @objc func artistClicked() {
//        artistProfile = true
//        self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer), animated: true)
//    }
    
    @objc func followClicked() {
        if followButton.borderWidth == 0.5 {
            followText.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followButton.style.preferredSize = CGSize(width: 75, height: 25)
            followButton.backgroundColor = UIColor().soundbarColorScheme()
            followButton.borderWidth = 0
        }
        else {
            followText.attributedText = NSAttributedString(string: "Unfollow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followButton.style.preferredSize = CGSize(width: 75, height: 25)
            followButton.backgroundColor = UIColor.clear
            followButton.borderWidth = 0.5
            followButton.borderColor = UIColor.white.cgColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

//
//  ExplorePlaylistCellData.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-04.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ExplorePlaylistCellData: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var cellType: String!
    
    var collectionNode: ASCollectionNode?
    let trendingText = ASTextNode()
    let trendingListens = ASTextNode()
    let cellSeparatorImage = ASImageNode()
    
    let suggestBackImage = ASImageNode()
    let userProfImage = ASNetworkImageNode()
    let nameText = ASTextNode()
    let usernameText = ASTextNode()
    let followButton = ASButtonNode()
    let followButtonBackground = ASImageNode()
    
    init(type: String) {
        super.init()
        cellType = type
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if cellType == "Trending" {
            let cellSeparatorCenter = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: cellSeparatorImage)
            let cellSeparatorCenterInset = ASInsetLayoutSpec(insets: .init(top: 6, left: 0, bottom: 0, right: 0), child: cellSeparatorCenter)
            
            let collectionInset = ASInsetLayoutSpec(insets: .init(top: 5, left: 10, bottom: 0, right: 0), child: collectionNode!)
            
            let hStartStack = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 0,
                                                justifyContent: .start,
                                                alignItems: .start,
                                                children: [trendingText])
            let leftPadding = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: hStartStack)
            
            let hEndStack = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0,
                                              justifyContent: .end,
                                              alignItems: .end,
                                              children: [trendingListens])
            let hEndStackCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: hEndStack)
            let rightPadding = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 15), child: hEndStackCenter)
            rightPadding.style.flexGrow = 1

            let hStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 0,
                                           justifyContent: .start,
                                           alignItems: .stretch,
                                           children: [leftPadding, rightPadding])
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 4,
                                     justifyContent: .start,
                                     alignItems: .stretch,
                                     children: [hStack, collectionInset, cellSeparatorCenterInset])
        } else {
            let followButtonCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: followButton)
            let followBackgroundOverlay = ASOverlayLayoutSpec(child: followButtonBackground, overlay: followButtonCenter)
            
            let vStackProfile = ASStackLayoutSpec(direction: .vertical,
                                                  spacing: 5,
                                                  justifyContent: .start,
                                                  alignItems: .center,
                                                  children: [userProfImage, nameText, usernameText, followBackgroundOverlay])
            return ASOverlayLayoutSpec(child: suggestBackImage, overlay: vStackProfile)
        }
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            return ExploreTrendingCellData()
        }
    }
    
    private func setupNodes() {
        if cellType == "Trending" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 80, height: 80)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 0
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()
            collectionNode!.delegate = self
            collectionNode!.dataSource = self
            
            collectionNode!.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 80)

            trendingText.attributedText = NSAttributedString(string: "#mixchallenge", attributes: [NSAttributedString.Key.foregroundColor : UIColor.yellow, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
            trendingListens.attributedText = NSAttributedString(string: "34m", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
            cellSeparatorImage.backgroundColor = .white
            cellSeparatorImage.style.preferredSize = .init(width: UIScreen.main.bounds.width - 20, height: 0.5)
            
        } else if cellType == "Suggested" {
            suggestBackImage.backgroundColor = .darkGray
//                UIColor(white: 1.0, alpha: 0.15)
            suggestBackImage.style.preferredSize = .init(width: 125, height: 175)
            suggestBackImage.cornerRadius = 5
            
            userProfImage.url = URL(string: "https://firebasestorage.googleapis.com/v0/b/soundbar-3d263.appspot.com/o/userProfileImages%2Fdababy%2Fprof-dababy?alt=media&token=086326c1-9169-4f69-bc23-7b6a0cdb80fb")
            userProfImage.style.preferredSize = .init(width: 90, height: 90)
            userProfImage.cornerRadius = 90/2
            userProfImage.borderWidth = 1
            userProfImage.borderColor = UIColor.white.cgColor
            
            nameText.attributedText = NSAttributedString(string: "Justin Cose", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            usernameText.attributedText = NSAttributedString(string: "@jayrcose", attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
            
            followButton.setTitle("Follow", with: UIFont.boldSystemFont(ofSize: 15), with: .black, for: .normal)
            followButtonBackground.backgroundColor = .yellow
            followButtonBackground.style.preferredSize = .init(width: 75, height: 25)
            followButtonBackground.cornerRadius = 5
            followButton.addTarget(self, action: #selector(followSuggestionsClicked), forControlEvents: .touchUpInside)
        }
    }
    
    @objc private func followSuggestionsClicked() {
        print("follow button clicked...")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

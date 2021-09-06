//
//  ShareFeedPopUp.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ShareFeedPopUpFeed: BaseNode, ASCollectionDelegate, ASCollectionDataSource,  UICollectionViewDelegateFlowLayout {
    
    var ShareIconsCollectionNode: ASCollectionNode!
    var shareIconsCell = ASImageNode()
    
    var cancelBackground = ASImageNode()
    var cancel = ASTextNode()
    var cancelButton = ASButtonNode()
    
    var cellSeperator = ASImageNode()

    var ShareIconsCollectionNodeAssets = ["FavoriteSharePageIcon", "RepostSharePageIcon", "AddToPlaylistSharePageIcon", "MessageSharePageIcon", "ViewArtistSharePageIcon"]
    var ShareIconsCollectionNodeCaptions = ["Favorite", "Repost",  "Add To Playlist", "Send", "View Artist"]
    
    var cellCount: Int!
    
    override init() {
        super.init()
        
        ShareIconsCollectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
            
            let collection = ASCollectionNode(collectionViewLayout: flowLayout)
            return collection
        }()
        
        ShareIconsCollectionNode.showsHorizontalScrollIndicator = false
        
        cellCount = ShareIconsCollectionNodeCaptions.count
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerCancelBackground = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: cancelBackground)
        
        let centerCancel = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: cancel)
        
        let cancelInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: centerCancel)
        
        let centerCancelButton = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: cancelButton)
        
        let cancelTextButtonOverlay = ASOverlayLayoutSpec(child: centerCancelButton, overlay: cancelInset)
        
        let cancelBackgroundOverlay = ASOverlayLayoutSpec(child: centerCancelBackground, overlay: cancelTextButtonOverlay)
        
        let shareVerticalStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 0,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [cellSeperator, ShareIconsCollectionNode, cancelBackgroundOverlay])
        
        return shareVerticalStack
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
            return ShareIconsCollectionNodeAssets.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
                return shareCellData(caption: (self?.ShareIconsCollectionNodeCaptions[indexPath.row])!, trendingData: (self?.ShareIconsCollectionNodeAssets[indexPath.row])!)
        }
    }
    
    func setupNodes() {
        cellSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.5)
        cellSeperator.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
        
        ShareIconsCollectionNode.dataSource = self
        ShareIconsCollectionNode.delegate = self
        ShareIconsCollectionNode.backgroundColor = UIColor().cellBackgroundGray()
        ShareIconsCollectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: CGFloat(cellCount) * 50)
        
        cancel.attributedText = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        cancel.maximumNumberOfLines = 1
        
        cancelBackground.backgroundColor = UIColor().topBackgroundGray()
        cancelBackground.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 115)

        cancelButton.style.preferredSize = .init(width: 50, height: 20)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), forControlEvents: .touchUpInside)
    }
    
    @objc private func cancelButtonClicked() {
        NotificationCenter.default.post(name: Notification.Name("cancelSharePopUp"), object: nil)
    }
    
    override func didExitVisibleState() {
        self.closestViewController?.dismiss(animated: false, completion: nil)

    }
}



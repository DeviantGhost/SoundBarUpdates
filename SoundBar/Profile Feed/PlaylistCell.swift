//
//  PlaylistCell.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-20.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class PlaylistCell: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var dataSource: ProfileMusic!
    let collectionTitle = ASTextNode()
    var collectionNode: ASCollectionNode!
    var isOtherArtist: Bool!
    var isFavorites: Bool!  // to determine what kind of cell to display(vertical/horizontal collection)
    var isTracks: Bool!
    var isRecommended: Bool! = false
    let backgroundImageRecommended = ASImageNode()
    
    init(title: String, playlists: ProfileMusic?, isArt: Bool) {
        super.init()
        isOtherArtist = isArt
        dataSource = playlists
        if title == "Playlists" {
            isFavorites = false
            isTracks = false
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 180, height: 180)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 10
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()
            collectionTitle.attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        } else if title == "Favorites" || title == "Recommended" {
            isFavorites = true
            isTracks = false
            title == "Recommended" ? (isRecommended = true) : (isRecommended = false)
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 25
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()
            collectionTitle.attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        } else {
            isTracks = true
            isFavorites = false
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 10
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()
            collectionTitle.attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        }
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var titleInset: ASLayoutElement!
        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 10), child: collectionNode)
        if !isFavorites {
            titleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: collectionTitle)
        } else {
            titleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 15, right: 0), child: collectionTitle)
        }

        if isOtherArtist || isTracks {
            let vStack = ASStackLayoutSpec(direction: .vertical,
                                     spacing: 0,
                                     justifyContent: .start,
                                     alignItems: .start,
                                     children: [collectionInset])
            return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 10, right: 0), child: vStack)
        }
        if isRecommended {
            let vStack = ASStackLayoutSpec(direction: .vertical,
                                     spacing: 0,
                                     justifyContent: .start,
                                     alignItems: .start,
                                     children: [titleInset, collectionInset])
            let vStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 10, right: 0), child: vStack)
            return ASBackgroundLayoutSpec(child: vStackInset, background: backgroundImageRecommended)
        }
        let vStack = ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0,
                                 justifyContent: .start,
                                 alignItems: .start,
                                 children: [titleInset, collectionInset])
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 10, right: 0), child: vStack)
    }

    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if isFavorites {
            return (dataSource.userPlaylists?.favorites!.count)!
        } else if isTracks {
            return dataSource.userTracks!.count
        } else {
            return dataSource.userPlaylists!.playlists!.count
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            if self!.isFavorites {
                return PlaylistCellData(data: self?.dataSource.userPlaylists?.favorites![indexPath.row], type: self!.isFavorites, recommended: self!.isRecommended)
            } else if self!.isTracks {
                return PlaylistCellData(data: self?.dataSource.userTracks![indexPath.row], type: self!.isTracks)
            } else {
                return PlaylistCellData(data: self?.dataSource.userPlaylists!.playlists![indexPath.row], type: self!.isFavorites)
            }
        }
    }
    
    private func setupNodes() {
        collectionNode.delegate = self
        collectionNode.dataSource = self
        if isFavorites || isTracks || isRecommended {
            if isRecommended {
                collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 260)
                backgroundImageRecommended.image = .init(imageLiteralResourceName: "reverseTrendingBackground")
                backgroundImageRecommended.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 260)
            } else {
                collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
            }
        } else {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 215)
        }
    }
}

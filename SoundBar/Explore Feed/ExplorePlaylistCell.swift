//
//  ExplorePlaylistCell.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-03.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ExplorePlaylistCell: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    var cellType: String!
    let artistsBoldText = ASTextNode()
    let artistsSmallText = ASTextNode()
    let backgroundImage = ASImageNode()
    
    let todaysHitsText = ASTextNode()
    let backgroundImageTop = ASImageNode()
    let backgroundImageBottom = ASImageNode()
    
    init(type: String) {
        super.init()
        cellType = type
        self.backgroundColor = .black
        if type == "Header" || type == "AD" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 200, height: 200)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 10
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()
            if type == "AD" {
                collectionNode = {
                    let flowLayout = UICollectionViewFlowLayout()
                    flowLayout.itemSize = CGSize(width: 100, height: 100)
                    flowLayout.scrollDirection = .horizontal
                    flowLayout.minimumLineSpacing = 10
                    let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                    collection.backgroundColor = .clear
                    
                    return collection
                }()
            }
        } else if type == "Trending" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 130)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()
        } else {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 125, height: 175)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 10
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()
        }
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if cellType == "Suggested" {
            let vStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .start,
                                           alignItems: .stretch,
                                           children: [artistsBoldText, artistsSmallText, collectionNode])
            return ASInsetLayoutSpec(insets: .init(top: 15, left: 10, bottom: 0, right: 0), child: vStack)
        } else if cellType == "Trending" {
            return ASOverlayLayoutSpec(child: backgroundImage, overlay: collectionNode)
        } else if cellType == "Header" {
            let vStackBackground = ASStackLayoutSpec(direction: .vertical,
                                                     spacing: 0,
                                                     justifyContent: .start,
                                                     alignItems: .stretch,
                                                     children: [backgroundImageTop, backgroundImageBottom])
            let titleInset = ASInsetLayoutSpec(insets: .init(top: 5, left: 10, bottom: 10, right: 0), child: todaysHitsText)
            let collectionInset = ASInsetLayoutSpec(insets: .init(top: -20, left: 10, bottom: 0, right: 0), child: collectionNode)
            
            let vStackMain = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 0,
                                               justifyContent: .start,
                                               alignItems: .start,
                                               children: [titleInset, collectionInset])
            
            return ASOverlayLayoutSpec(child: vStackBackground, overlay: vStackMain)
        }
        return ASInsetLayoutSpec(insets: .zero, child: collectionNode)
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if cellType == "Trending" {
            return 3
        }
        return 5
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            if self?.cellType == "Header" {
                return ExplorePlaceholderImage()
            } else if self?.cellType == "Trending" {
                return ExplorePlaylistCellData(type: self!.cellType)
            } else if self?.cellType == "AD" {
                return ExploreAdSpace()
            } else {
                return ExplorePlaylistCellData(type: self!.cellType)
            }
        }
    }
    
    private func setupNodes() {
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 215)
        
        if cellType == "AD" {
            collectionNode.style.preferredSize = .init(width: 150, height: 150)
            collectionNode.backgroundColor = .black
        } else if cellType == "Header" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 300)

            todaysHitsText.attributedText = NSAttributedString(string: "Todays Hits", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
            
            backgroundImageTop.image = .init(imageLiteralResourceName: "trendingBackgroundTop")
            backgroundImageTop.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 150)
            
            backgroundImageBottom.image = .init(imageLiteralResourceName: "trendingBackground")
            backgroundImageBottom.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 150)
        } else if cellType == "Trending" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 390)
            backgroundImage.image = .init(imageLiteralResourceName: "trendingBackground")
            backgroundImage.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 390)
        } else if cellType == "Suggested" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width - 10, height: 215)
            collectionNode.backgroundColor = .clear
            artistsBoldText.attributedText = NSAttributedString(string: "Artists to Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
            
            artistsSmallText.attributedText = NSAttributedString(string: "Based on your listening history", attributes: [NSAttributedString.Key.foregroundColor : UIColor.yellow, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

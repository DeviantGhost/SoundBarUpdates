//
//  ExplorePlaylistCell.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-03.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class ExploreCollectionCells: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    var cellType: String!
    let titleText = ASTextNode()

    var dataSource: [Any]!
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    let cellCollectionsViewModel = CellCollectionsViewModel()
    
    var favorites = hotBarsDataSourceStatic
    
    var playlistCreatedBy = ["You", "Katie L", "You", "Ryan R", "Carlon R", "Austin T", "Grace Dowser", "Jack S", "John Smith", "You", "Danesh", "Eric Issakson", "Lukas Theo", "You", "Jake Druckman", "Nicole R", "James", "Rachel R", "Oliver Dover", "Justin"]
    
    var playlistNames = ["Chilling", "Vibes", "Party Playlist", "Driving", "Just Chillin", "Livin it up", "Lazy Playlist", "Workout", "Running", "Working", "Mellow Playlist", "Pregame",  "Go Crazy", "Classics", "Oldies", "Throwback Vibes", "Gaming Playlist", "Lit", "Fun Songs", "Sad Songs"]
    
    var recentHistoryTypes = ["Song", "Artist", "Playlist", "Song", "Artist", "Playlist", "Song", "Artist", "Song", "Artist", "Playlist", "Song", "Artist", "Playlist", "Song", "Artist", "Song", "Artist", "Playlist", "Song"]
    
    init(type: String!, data: [Any], audio: AudioHandler, animationHandle: SongsAnimationHandler) {
        super.init()
        
        cellType = type
        
        audioPlayer = audio
        animationHandler = animationHandle
        dataSource = data
        
        self.backgroundColor = .clear
    
        if type == "BarCharts" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                collection.isPagingEnabled = true
                return collection
            }()}
        
        else if type == "OnFire" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 200, height: 300)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 10
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        else if type == "TrendingArtists" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 240, height: 275)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 10
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        else if type == "RecommendedPlaylists" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 250, height: 250)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 0
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        else if type == "NewMusic" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 200, height: 300)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 10
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        else if type == "SoundbarArtists" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: 240, height: 275)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 10
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        else if type == "BeGenre" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 375)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 0
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        else if type == "UpAndComing" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width:  UIScreen.main.bounds.width, height: 80)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        else if type == "ExploreHistory" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 65)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                
                return collection
            }()}
        
        
        else {
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
        
        cellCollectionsViewModel.reloadTableView = { self.collectionNode.reloadData() }
        cellCollectionsViewModel.loadCellData(animationHandle: animationHandle, audio: audio, data: data, type: type)
        
        collectionNode.delegate = self
        collectionNode.dataSource = self

        setupNodes()
    }
    
    override func didLoad() {
        collectionNode.view.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let titleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 10, right: 0), child: titleText)

        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: collectionNode)
        
        let vStackMain = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .center,
                                           alignItems: .baselineFirst,
                                           children: [titleInset, collectionInset])
        
        return vStackMain
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
            return cellCollectionsViewModel.numberOfSections
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if cellType == "ExploreHistory" {
            return 20
        }
        else if cellType == "UpAndComing" {
            return 5
        }
        else if cellType == "OnFire" {
            return cellCollectionsViewModel.numberOfItems
        }
        else if cellType == "TrendingArtists" {
            return cellCollectionsViewModel.numberOfItems
        }
        else if cellType == "RecommendedPlaylists" {
            return cellCollectionsViewModel.numberOfItems
        }
        else if cellType == "NewMusic" {
            return cellCollectionsViewModel.numberOfItems
       }
        else if cellType == "SoundbarArtists" {
            return cellCollectionsViewModel.numberOfItems
       }
        else if cellType == "UpAndComing" {
            return cellCollectionsViewModel.numberOfItems
        }
        else {
            return 1
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            if self?.cellType == "ExploreHistory" {
                return SearchHistoryCells(playlist: self!.playlistNames[indexPath.row], createdBy: self!.playlistCreatedBy[indexPath.row], clickedSong: self!.favorites[indexPath.row], audio: self!.audioPlayer, animationHandle: self!.animationHandler, cellType: self!.recentHistoryTypes[indexPath.row])
            }
            else {
                return self!.cellCollectionsViewModel.getCellAt(cell: indexPath)
            }
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("node: clicked at \(indexPath.row)")
    }
    
    private func setupNodes() {
        if cellType == "ExploreHistory" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 20 * 65)
            titleText.attributedText = NSAttributedString(string: "Trending Searches", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        }
        else if cellType == "OnFire" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 325)
            collectionNode.backgroundColor = .clear
            
            titleText.attributedText = NSAttributedString(string: "On Fire", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        }
        else if cellType == "TrendingArtists" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 280)
            collectionNode.backgroundColor = .clear
            
            titleText.attributedText = NSAttributedString(string: "Trending Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        }
        else if cellType == "NewMusic" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 325)
            collectionNode.backgroundColor = .clear
            
            titleText.attributedText = NSAttributedString(string: "New Music", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        }
        else if cellType == "SoundbarArtists" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 280)
            collectionNode.backgroundColor = .clear
            
            titleText.attributedText = NSAttributedString(string: "Soundbar Affiliates", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        }
        else if cellType == "RecommendedPlaylists" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 270)
            collectionNode.backgroundColor = .clear
            
            titleText.attributedText = NSAttributedString(string: "Playlists For You", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
            
        }
        else if cellType == "UpAndComing" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 400)
            collectionNode.backgroundColor = .clear
            
            titleText.attributedText = NSAttributedString(string: "You Should Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

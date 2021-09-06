//
//  LibraryCollectionData.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-07-25.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
 
var latestPlaylist: SongPlaylists!

class LibraryCollectionData: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    var librarySearch: LibrarySearchTop!

    var collectionEdited = songBoxDisplaying
    
    var cellType: String!
                
    var playlistCreatedBy = ["You", "Katie L", "You", "Ryan R", "Carlon R", "Austin T", "Grace Dowser", "Jack S", "John Smith", "You", "Danesh", "Eric Issakson", "Lukas Theo", "You", "Jake Druckman", "Nicole R", "James", "Rachel R", "Oliver Dover", "Justin"]
    var playlistNames = ["Chilling", "Vibes", "Party Playlist", "Driving", "Just Chillin", "Livin it up", "Lazy Playlist", "Workout", "Running", "Working", "Mellow Playlist", "Pregame",  "Go Crazy", "Classics", "Oldies", "Throwback Vibes", "Gaming Playlist", "Lit", "Fun Songs", "Sad Songs"]
    var recentHistoryTypes = ["Song", "Artist", "Playlist", "Song", "Artist", "Playlist", "Song", "Artist", "Song", "Artist", "Playlist", "Song", "Artist", "Playlist", "Song", "Artist", "Song", "Artist", "Playlist", "Song"]
    
    var playlists: [SongPlaylists]? = nil
    var artists: [ProfileHeader]? = nil
    var favorites: [SongPresentation]? = nil
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    var recentSearchesText = ASTextNode()

    var collectionNodePosition = CGFloat(0)
    var collectionHeight = CGFloat(0.0)
    
    var dataSource: [String: Any]!
    
    init(tab: String!, cellData: [String: Any], audio: AudioHandler, animationHandle: SongsAnimationHandler, dataPosition: CGFloat) {
        super.init()
        
        recentHistoryTypes.shuffle()
        playlistCreatedBy.shuffle()
        
        cellType = tab
        audioPlayer = audio
        dataSource = cellData
        animationHandler = animationHandle
        collectionNodePosition = dataPosition
        
        self.backgroundColor = .clear
        automaticallyManagesSubnodes = true

        if cellType == "Playlists" {
            playlists = cellData["playlists"] as? [SongPlaylists]
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
        else if cellType == "Artists" {
            artists = cellData["artists"] as? [ProfileHeader]
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
        else if cellType == "History" {
            playlists = cellData["playlists"] as? [SongPlaylists]
            artists = cellData["artists"] as? [ProfileHeader]
            favorites = cellData["favorites"] as? [SongPresentation]
       
            playlists?.shuffle()
            artists?.shuffle()
            favorites?.shuffle()
            
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 65)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
        else {
            favorites = cellData["favorites"] as? [SongPresentation]
            favorites?.shuffle()
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        setupNodes()
        
        DispatchQueue.main.async {
            self.collectionNode.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentTab == "History" {
            if (scrollView.contentOffset.y < 0) {
                recentSearchesText.removeFromSupernode()
                NotificationCenter.default.post(name: Notification.Name("clearLibrarySearchBar"), object: nil)
                searchOpen = false
            }
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("closeKeyboard"), object: nil)
            }
        }
    }
    
    @objc func reloadCollection(){
        
    }
    
    override func didEnterVisibleState() {
        collectionEdited = songBoxDisplaying
    }
    
    override func didLoad() {
        collectionNode.view.showsVerticalScrollIndicator = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [collectionNode])
        if currentTab == "History" {

            textStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 10,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [recentSearchesText, collectionNode])
        }
        return textStack
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if cellType == "Playlists" {
                return playlists?.count ?? 0
            }
            else if cellType == "Artists" {
                return artists?.count ?? 0
            }
            else if cellType == "History" {
                return 20
            }
            else {
                return favorites?.count ?? 0
            }
        }
        else{
            return 1
        }
    }
    
    var isFavorites = true
    var isRecommended = true
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            if indexPath.section == 0 {
                if self?.cellType == "Playlists" {
                    let index = Int.random(in: 0..<self!.playlistCreatedBy.count)
                    let cell = PlaylistsCell(playlist: self!.playlists![indexPath.row], createdBy: self!.playlistCreatedBy[index], audio: self!.audioPlayer, animationHandle: self!.animationHandler)
                    cell.delegate = self
                    return cell
                }
                else if self?.cellType == "Artists" {
                    let cell = ArtistsCell(userProfile: self!.artists![indexPath.row], audio: (self?.audioPlayer)!)
                    cell.delegate = self
                    return cell
                }
                else if self?.cellType == "History" {
                    return SearchHistoryCells(playlist: self!.playlistNames[indexPath.row], createdBy: self!.playlistCreatedBy[indexPath.row], clickedSong: self!.favorites![indexPath.row], audio: self!.audioPlayer, animationHandle: self!.animationHandler, cellType: self!.recentHistoryTypes[indexPath.row])
                }
                else {
                    let cell = SongsCell(clickedSong: self!.favorites![indexPath.row], audio: self!.audioPlayer, animationHandle: self!.animationHandler)
                    cell.delegate = self
                    return cell
                }
            }
            else{
                return LibraryDetails(tab: currentTab, cellData: self!.dataSource)
            }
        }
    }

    private func setupNodes() {
        collectionHeight = UIScreen.main.bounds.height - (collectionNodePosition + tabBarHeight)
            
        collectionNode.backgroundColor = .clear
        
        if cellType == "History" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: collectionHeight)
        }
        else if cellType == "Playlists" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: collectionHeight)
        }
        else if cellType == "Artists" {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: collectionHeight)
        }
        else {
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: collectionHeight)
        }
        
        recentSearchesText.attributedText = NSAttributedString(string: "Recently Searched", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        recentSearchesText.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 35)
        recentSearchesText.backgroundColor = UIColor().topBackgroundGray()
        recentSearchesText.zPosition = 13
        recentSearchesText.textContainerInset = .init(top: 10, left: 7.5, bottom: 0, right: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

extension LibraryCollectionData : SongsCellDelegate {
    func delete(cell: SongsCell){
        if let indexPath = collectionNode?.indexPath(for: cell) {
            favorites?.remove(at: indexPath.row)
            collectionNode.deleteItems(at: [indexPath])
        }
    }
}

extension LibraryCollectionData : ArtistsCellDelegate {
    func delete(cell: ArtistsCell){
        if let indexPath = collectionNode?.indexPath(for: cell) {
            artists?.remove(at: indexPath.row)
            collectionNode.deleteItems(at: [indexPath])
        }
    }
}

extension LibraryCollectionData : PlaylistsCellDelegate {
    func delete(cell: PlaylistsCell){
        if let indexPath = collectionNode?.indexPath(for: cell) {
            playlists?.remove(at: indexPath.row)
            collectionNode.deleteItems(at: [indexPath])
        }
    }
}

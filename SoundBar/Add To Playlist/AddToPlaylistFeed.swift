//
//  AddToPlaylistFeed.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class AddToPlaylistFeed: BaseNode, ASTableDelegate, ASTableDataSource {

    var playerItem: AVPlayerItem!
    let tableNode = ASTableNode()
    
    var followSearchBar: AddToPlaylistSearch!
    var followTop: AddToPlaylistTop!
    
    var audioPlayer: AudioHandler!
    let animationHandler = SongsAnimationHandler()
    let profileHomeViewModel = ProfileHomeViewModel()
    
    var data: ProfileHeader!
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearchBar), name: NSNotification.Name("clearSearchBar"), object: nil)
        
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.zPosition = 2
  
        self.backgroundColor = UIColor().backgroundGray()
        tableNode.backgroundColor = UIColor.clear
        
        profileHomeViewModel.reloadTableView = {
            self.tableNode.reloadData()
        }
        
    }
    
    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
       // profileHomeViewModel.loadCellData(animationHandle: animationHandler, audio: audioPlayer, isArt: isArtist, profile: data)
    }
    
    @objc func clearSearchBar() {
        DispatchQueue.main.async {
            self.followSearchBar.searchText.resignFirstResponder()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            self.followSearchBar.searchText.resignFirstResponder()
        }
    }
    
    override func didEnterVisibleState() {
        followTop = AddToPlaylistTop()
        followTop.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        followTop.backgroundColor = UIColor().topBackgroundGray()
        followTop.zPosition = 15
        view.addSubnode(followTop)
        
        followSearchBar = AddToPlaylistSearch()
        followSearchBar.frame = CGRect(x: (((UIScreen.main.bounds.width)-(UIScreen.main.bounds.width - 20)) / 2), y: 75, width: UIScreen.main.bounds.width - 20, height: 35)
        followSearchBar.zPosition = 10
        view.addSubnode(followSearchBar)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 120, left: 0, bottom: 0, right: 0), child: tableNode)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        print("fetching new data")
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return AddToPlaylistCells()
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("item clicked...\n hereee")
    }
    
}


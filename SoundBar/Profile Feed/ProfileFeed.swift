//
//  ProfileFeed.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-20.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ProfileFeed: BaseNode, ASTableDelegate, ASTableDataSource {
    
    let tableNode = ASTableNode()
    var musicDataSource: UserProfileDataModel!
    var isTrackDisplay: Bool! = false
    
    override init() {
        super.init()
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = .black
        setupDatasource()
        NotificationCenter.default.addObserver(self, selector: #selector(libraryButtonClicked), name: NSNotification.Name.init(rawValue: "libraryButtonClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tracksButtonClicked), name: NSNotification.Name.init(rawValue: "tracksButtonClicked"), object: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: tableNode)
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
        if isTrackDisplay {
            return 2
        }
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let details = musicDataSource.profileDetails[3].profileHeader
        let music = musicDataSource.profileDetails[3].profileMusic
        let isOtherArtist = musicDataSource.profileDetails[3].otherArtist!
        
        isOtherArtist == true ? (isTrackDisplay = true) : nil
        return { [weak self] in
            if indexPath.section == 0 {
                return ProfileData(userData: details!, isArtist: (isOtherArtist, music?.userTracks == nil))
            } else if indexPath.section == 1 {
                if music?.userPlaylists?.playlists == nil || self!.isTrackDisplay {
                    return PlaylistCell(title: "Tracks", playlists: music, isArt: isOtherArtist)
                }
                return PlaylistCell(title: "Playlists", playlists: music, isArt: isOtherArtist)
            } else {
                if music?.userPlaylists?.favorites != nil && !(music?.userPlaylists?.favorites?.isEmpty)! {
                    return PlaylistCell(title: "Favorites", playlists: music, isArt: isOtherArtist)
                }
                return ASCellNode()
            }
        }
    }
    
    @objc private func tracksButtonClicked() {
        isTrackDisplay = true
        self.tableNode.reloadData()
    }
    
    @objc private func libraryButtonClicked() {
        isTrackDisplay = false
        self.tableNode.reloadData()
    }
    
    private func setupDatasource() {
        let profilePath = Bundle.main.path(forResource: "profile", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: profilePath))
        musicDataSource = try! JSONDecoder().decode(UserProfileDataModel.self, from: data)
    }
}

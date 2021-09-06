//
//  ExploreFeedViewModel.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-20.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class ExploreFeedViewModel {
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?

    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    var songData = [SongPresentation]()
    var artistData = [ProfileHeader]()
    var playlistData = [SongPlaylists]()
    
    var numberOfRows: Int { return 1 }
    var numberOfSections: Int { return 7 }
    
    var getSongData: [SongPresentation] { return songData }
    var getplaylistData: [SongPlaylists] { return playlistData }
    var getRecommendedUsers: [ProfileHeader] { return artistData }
    
    var exploreFeedData: [SongPresentation] = [SongPresentation]() {
        didSet {
            reloadTableView!()
        }
    }
    
    func loadCellData(animationHandle: SongsAnimationHandler, audio: AudioHandler) {
        animationHandler = animationHandle
        audioPlayer = audio
        setupDatasource()
    }
    
    func getCellAt(cell: IndexPath) -> ASCellNode {
        if exploreHistory == true {
            if cell.section == 0 {
            return ExploreCollectionCells(type: "ExploreHistory", data: self.songData, audio: self.audioPlayer!, animationHandle: self.animationHandler)
            }
            else {
                return ASCellNode()
            }
        }
        
        else {
            if cell.section == 0 {
                return ExploreCollectionCells(type: "OnFire", data: self.songData, audio: self.audioPlayer!, animationHandle: self.animationHandler)
            }
            else if cell.section == 1 {
                return ExploreCollectionCells(type: "TrendingArtists", data: self.artistData, audio: self.audioPlayer!, animationHandle: self.animationHandler)
            }
            else if cell.section == 2 {
                return ExploreCollectionCells(type: "RecommendedPlaylists", data: self.playlistData, audio: self.audioPlayer!, animationHandle: self.animationHandler)
            }
            else if cell.section == 3 {
                return ExploreCollectionCells(type: "NewMusic", data: self.playlistData, audio: self.audioPlayer!, animationHandle: self.animationHandler)
            }
            else if cell.section == 4 {
                return ExploreCollectionCells(type: "SoundbarArtists", data: self.artistData, audio: self.audioPlayer!, animationHandle: self.animationHandler)
            }
            else if  cell.section == 5 {
                return ExploreCollectionCells(type: "UpAndComing", data: self.artistData, audio: self.audioPlayer!, animationHandle: self.animationHandler)
            }
            else {
                return ExploreDetails()
            }
        }
    }
    
    private func setupDatasource() {
        self.songData = hotBarsDataSourceStatic.shuffled()
        self.playlistData = playlistsStatic
        self.artistData = artistProfilesStatic.shuffled()
    }
    
    func switchBottomSongData(cellType: String) {
        if cellType == "onFire" {
        NotificationCenter.default.post(name: NSNotification.Name("switchFullSongData"), object: nil, userInfo: ["songs" : songData])
        }
    }
}

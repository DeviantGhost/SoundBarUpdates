//
//  ProfileHomeViewModel.swift
//  SoundBar
//
//  Created by Justin Cose on 7/8/21.
//  Copyright © Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class ProfileHomeViewModel {

    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?

    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    var tracks: [SongPresentation] = [SongPresentation]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
        }
    }
    
    var reposts: [SongPresentation] = [SongPresentation]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
        }
    }
    
    var dataSource: [String: Any] = [String: Any]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
        }
    }

    var numberOfRows: Int { return 1 }
    var numberOfSections: Int { return 3 }
    var isArtist: Bool!
    var profile: ProfileHeader!
    
    func loadCellData(animationHandle: SongsAnimationHandler, audio: AudioHandler, isArt: Bool, profile: ProfileHeader) {
        animationHandler = animationHandle
        audioPlayer = audio
        isArtist = isArt
        self.profile = profile
        setupDatasource()
    }

    func getSectionAt(section: Int, profilePage: (profileHomeTop: ProfileInfo?, profileHomeTabBar: ProfileFeedButtons?)) -> ASCellNode {
        if section == 0 {
            return profilePage.profileHomeTop ?? ProfileInfo(userProfile: profile)
        }
        else if section == 1 {
            return profilePage.profileHomeTabBar ?? ProfileFeedButtons()
        }
        else {
            return RepostsCollectionNode(tab: "Reposts", cellData: self.dataSource, audio: self.audioPlayer, animationHandle: self.animationHandler, isArt: isArtist)
        }
    }

    func setupDatasource() {
        self.reposts = Array(hotBarsDataSourceStatic.prefix(upTo: 35))
        self.tracks = Array(hotBarsDataSourceStatic.prefix(upTo: 35))
        self.dataSource = ["reposts": self.reposts, "tracks": self.tracks]
    }
}


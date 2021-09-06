//
//  ProfileFeedViewModel.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var newPlaylist = SongPlaylists()

class LibraryFeedViewModel {
    
    var artistProfilePictures = ["LukeGawnePfp", "SeppiPfp", "KanyePfp", "RemixPfp", "hippiesabotage", "GhostPfp", "EdSheeranPfp", "NavPfp", "MaskedWolfPfp", "YungGravyPfp"]
    var names = ["Luke Gawne", "SEPPI", "Kanye West", "John Smith", "Hippie Sabotage", "Oliver Daner", "Ed Sheeran", "NAV", "KANE", "Yung Gravy"]
    var usernames = ["@lukegawneofficial", "@therealseppi", "@kanyewest", "@johnsmith", "@hippiesabotage", "@caughtaghost","@edsheeran", "@navofficial", "@maskedwolf", "@yunggravy"]
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?

    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!

    var playlists: [SongPlaylists] = [SongPlaylists]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
        }
    }
    
    var artists: [ProfileHeader] = [ProfileHeader]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
        }
    }
    
    var favorites: [SongPresentation] = [SongPresentation]() {
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
    var profile: ProfileHeader!
    var playlistIndex: Int!

    func loadCellData(animationHandle: SongsAnimationHandler, audio: AudioHandler, profile: ProfileHeader) {
        animationHandler = animationHandle
        audioPlayer = audio
        self.profile = profile
        setupDatasource()

    }

    func getSectionAt(section: Int, libraryPage: (libraryTop: LibrarySearchTop?, libraryTabBar: LibraryButtons?), collectionPosition: CGFloat) -> ASCellNode {
        if section == 0 {
            return libraryPage.libraryTop ?? LibrarySearchTop()
        }
        else if section == 1{
            if currentTab != "History" {
                return libraryPage.libraryTabBar ?? LibraryButtons()
            }else{
                return ASCellNode()
            }
        }
        else{
            return LibraryCollectionData(tab: currentTab, cellData: self.dataSource, audio: self.audioPlayer, animationHandle: self.animationHandler, dataPosition: collectionPosition)
        }
    }

    func setupDatasource() {
        self.playlists = playlistsStatic
        self.artists = artistProfilesStatic
        self.favorites = Array(hotBarsDataSourceStatic.prefix(upTo: 35))
        self.dataSource = ["playlists": self.playlists, "artists": self.artists, "favorites": self.favorites]
    }
    
    func reloadDatasourcePlaylist(){
        latestPlaylist = SongPlaylists(imageLink: "", playlistName: currentPlaylistName, songs: songsCellData, creator: "You")
        
        if songsCellData.count != 0 {
            playlists.append(latestPlaylist)
            
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
            self.dataSource["playlists"] = self.playlists
        }
        else{
            NotificationCenter.default.post(name: Notification.Name("deletePlaylist"), object: nil)
        }
    }
    
    func reloadEditDatasourcePlaylist(){
        newPlaylist = SongPlaylists(imageLink: "", playlistName: playlistNameGlobal, songs: songsCellData)
        playlistIndex = playlists.count - 1
        
        if songsCellData.count != 0 {
            playlists[playlistIndex] = newPlaylist
            
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
            
            self.dataSource["playlists"] = self.playlists
        }
        else{
            playlistsStatic.remove(at: playlistIndex)
            DispatchQueue.main.async {
                self.reloadTableView!()
            }
            self.dataSource["playlists"] = self.playlists
            NotificationCenter.default.post(name: Notification.Name("deletePlaylist"), object: nil)
        }
    }
}

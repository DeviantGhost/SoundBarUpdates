//
//  HomeFeedViewModel.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-15.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation

class HomeFeedViewModel {
        
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    var hotBarsDataSource: [Any] = hotBarsDataSourceStatic
    var followingFeedDatasource: [SongPresentation] = hotBarsDataSourceStatic
    
    var isHotBars: Bool = true
    var spacePassed: Double = 0.0
    
    var audioHandler: AudioHandler!
    
    var homefeedData: [SongPresentation] = [SongPresentation]() {
        didSet {
            reloadTableView!()
        }
    }
    
    var numberOfRows: Int { return homefeedData.count }
    var numberOfSections: Int { return 1 }

    func loadCellData(space: Double, audio: AudioHandler) {
        spacePassed = space
        audioHandler = audio

        if isHotBars {
            homefeedData = (hotBarsDataSource as! [SongPresentation]).shuffled()
        }
        
        else {
            homefeedData = followingFeedDatasource.shuffled()
        }
    }
    
    func getCellAt(row: Int, animationHandler: HomeAnimationHandler) -> CellData {
        let song = homefeedData[row]
        return CellData(song: song, backgroundImageSpace: spacePassed, following: !isHotBars, hotBars: isHotBars, audio: audioHandler, homeAnimationHandler: animationHandler)
    }
    
    func switchDataSources() {
        isHotBars = !isHotBars
        loadCellData(space: spacePassed, audio: audioHandler)
    }
}

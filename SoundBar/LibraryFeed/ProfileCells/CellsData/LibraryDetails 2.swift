//
//  LibraryDetails.swift
//  SoundBar
//
//  Created by Carlon Rosales on 8/30/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class LibraryDetails: BaseCellNode {
    
    var libraryCellsCount = Int(0)
    var libraryDetailText = ASTextNode()
    var background = ASImageNode()
    
    var cellType: String!

    var playlists: [SongPlaylists]? = nil
    var artists: [ProfileHeader]? = nil
    var favorites: [SongPresentation]? = nil
    
    let backgroundDimensions = CGSize(width: UIScreen.main.bounds.width, height: 110)
    
    init(tab: String!, cellData: [String: Any]){
        super.init()
        
        cellType = tab
        
        if cellType == "Playlists" {
            playlists = cellData["playlists"] as? [SongPlaylists]
            libraryCellsCount = playlists!.count
        }
        
        else if cellType == "Artists" {
            artists = cellData["artists"] as? [ProfileHeader]
            libraryCellsCount = artists!.count
        }
        
        else if cellType == "History" {
            playlists = cellData["playlists"] as? [SongPlaylists]
            artists = cellData["artists"] as? [ProfileHeader]
            favorites = cellData["favorites"] as? [SongPresentation]
            libraryCellsCount = playlists!.count + favorites!.count + artists!.count
        }
        
        else {
            favorites = cellData["favorites"] as? [SongPresentation]
            libraryCellsCount = favorites!.count
        }
        
        setUpNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let detailInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 20, bottom: 0, right: 0), child: libraryDetailText)
        let libraryDetails = ASOverlayLayoutSpec(child: background, overlay: detailInset)
        return libraryDetails
    }
    
    func setUpNodes(){
        background.style.preferredSize = backgroundDimensions
        background.backgroundColor = UIColor().topBackgroundGray()
        
        if cellType == "Playlists" {
            libraryDetailText.attributedText = NSAttributedString(string: "\(libraryCellsCount) Playlists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        }
        else if cellType == "Artists" {
            libraryDetailText.attributedText = NSAttributedString(string: "\(libraryCellsCount) Artists", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        }
        else if cellType == "History" {
            libraryDetailText.attributedText = NSAttributedString(string: "\(libraryCellsCount) Recent Searches", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        }
        else {
            libraryDetailText.attributedText = NSAttributedString(string: "\(libraryCellsCount) Favorites", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        }
    }
}

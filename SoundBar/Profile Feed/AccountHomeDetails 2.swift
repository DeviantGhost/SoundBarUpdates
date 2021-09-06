//
//  AccountHomeDetails.swift
//  SoundBar
//
//  Created by Carlon Rosales on 8/30/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class AccountHomeDetails: BaseCellNode {
    
    var songCellsCount = Int(0)
    var libraryDetailText = ASTextNode()
    var background = ASImageNode()
    
    var cellType: String!
        
    let backgroundDimentions = CGSize(width: UIScreen.main.bounds.width, height: 110)
    
    init(tab: String!, songs: [SongPresentation]){
        super.init()
        
        cellType = tab
        songCellsCount = songs.count
        
        setUpNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let detailInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 20, bottom: 0, right: 0), child: libraryDetailText)
        let libraryDetails = ASOverlayLayoutSpec(child: background, overlay: detailInset)
        return libraryDetails
    }
    
    func setUpNodes(){
        background.style.preferredSize = backgroundDimentions
        background.backgroundColor = UIColor().topBackgroundGray()
        
        if currentTabHome == "Reposts" {
            libraryDetailText.attributedText = NSAttributedString(string: "\(10) reposts", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        }
        else if currentTabHome == "Tracks" {
            libraryDetailText.attributedText = NSAttributedString(string: "\(songCellsCount) tracks", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        }
    }
}

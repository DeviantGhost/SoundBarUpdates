//
//  EditProfile.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-30.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class EditProfileFeed: BaseNode, ASTableDelegate, ASTableDataSource {
    
    var userInfo: ProfileHeader?

    var tableNode = ASTableNode()
    
    init(userData: ProfileHeader? = nil) {
        super.init()
        tableNode.allowsSelection = false
        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.leadingScreensForBatching = 0
        tableNode.backgroundColor = .black
        userInfo = userData
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: tableNode)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
         return 1
     }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            return EditProfileData()
        }
    }
}

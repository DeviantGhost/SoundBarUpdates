//
//  ProfileData.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-20.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ProfileData: BaseCellNode {
    
    var coverImage: ProfileCoverPhoto!
    var profileInfo: ProfileInfo!
    var profileTracksOption: ProfileTracksOption!
    
    init(userData: ProfileHeader, isArtist: (Bool, Bool)) {
        super.init()
        coverImage = ProfileCoverPhoto(userData: userData)
        profileInfo = ProfileInfo(userData: userData, isArt: isArtist)
        profileTracksOption = ProfileTracksOption(isArt: isArtist)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 10,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [coverImage, profileInfo, profileTracksOption])
    }
}

//
//  ProfileDetails.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-27.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct ProfileDetails: Codable {
    
    var profileHeader: ProfileHeader?
    var profileMusic: ProfileMusic?
    var otherArtist: Bool?
    var userId: Int!

    enum CodingKeys: String, CodingKey {
        case profileHeader = "profile_header"
        case profileMusic = "profile_music"
        case userId = "user_id"
        case otherArtist = "other_artist"
    }
}

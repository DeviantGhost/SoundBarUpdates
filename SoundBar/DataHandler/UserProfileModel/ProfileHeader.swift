//
//  ProfileHeader.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-27.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct ProfileHeader: Codable {
    var coverLink: String?
    var profileLink: String?
    var username: String?
    var followersCount: String?
    var followingCount: String?
    var likesCount: String?
    var bio: String?
    var bioLink: String?
<<<<<<< Updated upstream:SoundBar/DataHandler/UserProfileModel/ProfileHeader.swift
=======
    var fullName: String?
    var id: String?
    var socials: [String: String]?
    var listens: Int?
>>>>>>> Stashed changes:SoundBar/Model/UserProfileModel/ProfileHeader.swift
    
    enum CodingKeys: String, CodingKey {
        case coverLink = "cover_link"
        case profileLink = "profile_link"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case likesCount = "likes_count"
        case bioLink = "bio_link"

        case username
        case bio
    }
}

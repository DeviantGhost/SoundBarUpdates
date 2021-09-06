//
//  UserProfileDataModel.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-27.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct UserProfileDataModel: Codable {
    var profileDetails: [ProfileDetails]!
    
    enum CodingKeys: String, CodingKey {
        case profileDetails = "profile_details"
    }
}

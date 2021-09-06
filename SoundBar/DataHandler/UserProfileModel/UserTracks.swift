//
//  UserTracks.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-27.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct UserTracks: Codable {
    var imageLink: String!
    var songName: String!
    var listenCount: String!
    
    enum CodingKeys: String, CodingKey {
        case imageLink = "image_link"
        case songName = "song_name"
        case listenCount = "listen_count"
    }
}

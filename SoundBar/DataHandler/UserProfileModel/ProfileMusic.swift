//
//  ProfileMusic.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-27.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct ProfileMusic: Codable {
    var userTracks: [UserTracks]?
    var userPlaylists: UserPlaylists?
    
    enum CodingKeys: String, CodingKey {
        case userTracks = "user_tracks"
        case userPlaylists = "user_playlists"
    }
}

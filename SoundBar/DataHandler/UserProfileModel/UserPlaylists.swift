//
//  UserPlaylists.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-27.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct UserPlaylists: Codable {
    var playlists: [SongPlaylists]?
    var favorites: [UserTracks]?
    
    enum CodingKeys: String, CodingKey {
        case playlists
        case favorites
    }
}

//
//  SongPlaylists.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-28.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct SongPlaylists: Codable, Equatable {
    var id: UUID = UUID()
    var imageLink: String!
    var playlistName: String!
<<<<<<< Updated upstream:SoundBar/DataHandler/UserProfileModel/SongPlaylists.swift
=======
    var songs: [SongPresentation]?
    var creator: String!
>>>>>>> Stashed changes:SoundBar/Model/UserProfileModel/SongPlaylists.swift
    
    enum CodingKeys: String, CodingKey {
        case imageLink = "image_link"
        case playlistName = "playlist_name"
<<<<<<< Updated upstream:SoundBar/DataHandler/UserProfileModel/SongPlaylists.swift
=======
        case creator = "playlist_creator"
        case songs
>>>>>>> Stashed changes:SoundBar/Model/UserProfileModel/SongPlaylists.swift
    }
    
    static func == (lhs: SongPlaylists, rhs: SongPlaylists) -> Bool {
        return lhs.id == rhs.id
    }
}

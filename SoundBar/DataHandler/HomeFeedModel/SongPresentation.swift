//
//  SongArtwork.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation


struct SongPresentation: Codable {
    var fullLink: String?
    var snippetLink: String?
    var artist: String?
    var songName: String?
    var imageLink: String?
<<<<<<< Updated upstream:SoundBar/DataHandler/HomeFeedModel/SongPresentation.swift
    var comments: String?
    var likes: String?
    var listens: String?
=======
    var profileImageLink: String?
    var comments: Int?
    var likes: Int?
    var listens: Int?
>>>>>>> Stashed changes:SoundBar/Model/HomeFeedModel/SongPresentation.swift
    var songCaption: String?
    var shares: String?
    var hashtags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case fullLink = "full_song_link"
        case snippetLink = "snippet_song_link"
        case songName = "song_name"
        case imageLink = "image_link"
        case profileImageLink = "profile_link"
        case songCaption = "song_caption"
        case artist
        case comments
        case likes
        case listens
        case shares
        case hashtags
    }
}

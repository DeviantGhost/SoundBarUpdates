//
//  ListenerDataModel.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation

struct HomeFeedDataModel: Codable {
    var songsPresentation: [SongPresentation]?
    
    enum CodingKeys: String, CodingKey {
        case songsPresentation = "songs_presentation"
    }
}

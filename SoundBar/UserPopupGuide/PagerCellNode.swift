//
//  NotificationsModel.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-22.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation

struct NotificationsModel: Codable, Equatable, Identifiable {
    static func == (lhs: NotificationsModel, rhs: NotificationsModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    let profileImages: [String]
    let username: String
    let message: String
    let type: NotifType
    let likes: Int?
    let timestamp: String
    let songReference: String?
}

enum NotifType: String, Codable {
    case LikedComment
    case Repost
    case Released
    case TikTokProduction
    case Following
    case LikedProduction
}

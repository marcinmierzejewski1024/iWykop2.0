//
//  Comment.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation

struct Comments: Codable {
    let hot: Bool?
    let count: Int
    let items: [Item]?
}

struct Item: Codable {
    let editable: Bool
    let id: Int
    let author: Author
    let device: String
    let createdAt: Date
    let voted: Int
    let content: String
    let media: ItemMedia
    let adult: Bool
    let tags: [String]
    let favourite: Bool
    let votes: Votes
    let deletable: Bool
    let blacklist: Bool
    let deleted: String
    let resource: String
    let actions: ItemActions
    let archive: Bool
    let slug: String
    let parent: Parent?

    enum CodingKeys: String, CodingKey {
        case editable, id, author, device
        case createdAt = "created_at"
        case voted, content, media, adult, tags, favourite, votes, deletable, blacklist, deleted, resource, actions, archive, slug, parent
    }
}

struct ItemActions: Codable {
    let update: Bool
    let delete: Bool
    let voteUp: Bool
    let voteDown: Bool
    let createFavourite: Bool
    let deleteFavourite: Bool
    let report: Bool

    enum CodingKeys: String, CodingKey {
        case update, delete
        case voteUp = "vote_up"
        case voteDown = "vote_down"
        case createFavourite = "create_favourite"
        case deleteFavourite = "delete_favourite"
        case report
    }
}

struct ItemMedia: Codable {
    let photo: Photo
    let embed: Embed
}

struct Parent: Codable {
    let resource: String
    let id: Int
    let slug: String
    let author: Author
}

//
//  Entry.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation

struct Entry: Codable {
    let editable: Bool
    let id: Int
    let author: Author
    let device, createdAt: String
    let voted: Int
    let content: String
    let media: EntryMedia
    let adult: Bool
    let tags: [String]
    let favourite, deletable: Bool
    let slug: String
    let votes: Votes
    let comments: Comments
    let parentID: Int
    let resource: String
    let actions: EntryActions
    let archive, deleted: Bool

    enum CodingKeys: String, CodingKey {
        case editable, id, author, device
        case createdAt = "created_at"
        case voted, content, media, adult, tags, favourite, deletable, slug, votes, comments
        case parentID = "parent_id"
        case resource, actions, archive, deleted
    }
}

// MARK: - EntryActions
struct EntryActions: Codable {
    let update: Bool
    let delete: Bool
    let voteUp: Bool
    let createFavourite: Bool
    let deleteFavourite: Bool
    let report: Bool
    let voteDown: Bool?

    enum CodingKeys: String, CodingKey {
        case update, delete
        case voteUp = "vote_up"
        case createFavourite = "create_favourite"
        case deleteFavourite = "delete_favourite"
        case report
        case voteDown = "vote_down"
    }
}

// MARK: - EntryMedia
struct EntryMedia: Codable {
    let photo: Photo
    let embed: Embed
    let survey: Survey
}

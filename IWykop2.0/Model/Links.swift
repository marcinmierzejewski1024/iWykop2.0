//
//  Links.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation

struct Link: Codable {
    let editable: Bool
    let id: Int
    let createdAt: Date
    let title: String?
    let slug: String
    let description: String?
    let source: Source?
    let author: Author
    let publishedAt: Date?
    let votes: Votes
    let voted: Int
    let comments: Comments
    let tags: [String]
    let hot: Bool?
    let adult: Bool
    let media: LinkMedia
    let deletable: Bool
    let resource: String
    let actions: LinkActions
    let archive: Bool
    let deleted: Bool
    let device: String?
    let content: String?
    let favourite: Bool?
    let parentID: Int?

    enum CodingKeys: String, CodingKey {
        case editable, id
        case createdAt = "created_at"
        case title, slug, description, source, author
        case publishedAt = "published_at"
        case votes, voted, comments, tags, hot, adult, media, deletable, resource, actions, archive, deleted, device, content, favourite
        case parentID = "parent_id"
    }
}

struct LinkActions: Codable {
    let update: Bool
    let delete: Bool
    let voteUp: Bool
    let voteDown: Bool?
    let undoVote: Bool?
    let createFavourite: Bool
    let deleteFavourite: Bool
    let report: Bool
    let createAma: Bool?
    let finishAma: Bool?

    enum CodingKeys: String, CodingKey {
        case update, delete
        case voteUp = "vote_up"
        case voteDown = "vote_down"
        case undoVote = "undo_vote"
        case createFavourite = "create_favourite"
        case deleteFavourite = "delete_favourite"
        case report
        case createAma = "create_ama"
        case finishAma = "finish_ama"
    }
}

struct Votes: Codable {
    let up: Int
    let down: Int
    let users: [Author]?
    let count: Int?
}

struct LinkMedia: Codable {
    let photo: Photo
    let embed: Embed?
    let survey: Survey?
}

struct Survey: Codable {
    let key: String
    let question: String
    let voted: Int
    let count: Int
    let answers: [Answer]
    let actions: SurveyActions
}

struct SurveyActions: Codable {
    let create: Bool
    let update: Bool
    let delete: Bool
    let vote: Bool
}

struct Answer: Codable {
    let text: String
    let id: Int
    let count: Int
    let voted: Int
}

struct Source: Codable {
    let label: String
    let url: String
    let type: String
    let typeID: Int

    enum CodingKeys: String, CodingKey {
        case label, url, type
        case typeID = "type_id"
    }
}

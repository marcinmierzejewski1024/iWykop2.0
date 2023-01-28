//
//  Tags.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation

struct Tag: Codable {
    let editable: Bool
    let createdAt: Date
    let name: String
    let author: Author
    let personal: Bool
    let media: Media
    let description: String
    let followers: Int
    let follow: Bool
    let blacklist: Bool
    let actions: TagActions

    enum CodingKeys: String, CodingKey {
        case editable
        case createdAt = "created_at"
        case name, author, personal, media, description, followers, follow, blacklist, actions
    }
}

struct TagActions: Codable {
    let report: Bool
    let update: Bool
    let createCoauthor: Bool
    let deleteCoauthor: Bool
    let blacklist: Bool

    enum CodingKeys: String, CodingKey {
        case report, update
        case createCoauthor = "create_coauthor"
        case deleteCoauthor = "delete_coauthor"
        case blacklist
    }
}


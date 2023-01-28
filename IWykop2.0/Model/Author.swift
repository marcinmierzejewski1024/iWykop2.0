//
//  Author.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation

struct Author: Codable {
    let username: String
    let company: Bool
    let gender: String
    let avatar: String
    let note: Bool
    let online: Bool
    let status: String
    let color: Color
    let verified: Bool
    let follow: Bool
    let rank: Rank
    let actions: AuthorActions
}

struct AuthorActions: Codable {
    let update: Bool
    let updateGender: Bool
    let updateNote: Bool
    let blacklist: Bool
    let follow: Bool

    enum CodingKeys: String, CodingKey {
        case update
        case updateGender = "update_gender"
        case updateNote = "update_note"
        case blacklist, follow
    }
}

struct Color: Codable {
    let name: String
    let hex: String
    let hexDark: String

    enum CodingKeys: String, CodingKey {
        case name, hex
        case hexDark = "hex_dark"
    }
}

struct Rank: Codable {
    let position: Int
    let trend: Int
}

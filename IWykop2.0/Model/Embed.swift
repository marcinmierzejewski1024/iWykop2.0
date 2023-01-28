//
//  Embed.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation

struct Embed: Codable {
    let key: String
    let type: String
    let url: String
    let thumbnail: String
}

struct Photo: Codable {
    let key: String
    let label: String
    let mimeType: String
    let url: String
    let size: Int
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case key, label
        case mimeType = "mime_type"
        case url, size, width, height
    }
}

struct Media: Codable {
    let photo: Photo
}

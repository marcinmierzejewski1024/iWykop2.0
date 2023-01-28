//
//  Auth.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation
struct AuthResponse: Codable {
    let refreshToken: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case token
    }
}

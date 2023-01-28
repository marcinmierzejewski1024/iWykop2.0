//
//  Response.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 28/01/2023.
//

import Foundation

struct ApiResponse<ResponseDataType: Codable>: Codable {
    let code: Int?
    let hash: String?
    let error: ApiErrorResponse?
    let data: ResponseDataType?
    let pagination: Pagination?
}

struct ApiErrorResponse: Codable {
    let message: String
    let key: Int
}

struct Pagination: Codable {
    let perPage: Int
    let total: Int

    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case total
    }
}

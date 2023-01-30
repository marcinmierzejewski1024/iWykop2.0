//
//  ApiClient.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 27/01/2023.
//

import Foundation

enum APIError: Error {
    case invalidBody
    case invalidEndpoint
    case invalidURL
    case invalidResponse
    case apiError(ApiErrorResponse)
    case code(Int)
    case other(Error)
}

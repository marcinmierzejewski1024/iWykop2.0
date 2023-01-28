//
//  ApiClient.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 27/01/2023.
//

import Foundation

public typealias ApiRequestHeaders = [String: String]

public struct ApiRequestBody {
    var body: [String: String]

    func toData() throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: self.body, options: [])
        return jsonData
    }
}

public enum ApiRequest {
    case get(url: String, headers: ApiRequestHeaders?)
    case post(url: String, body: ApiRequestBody, headers: ApiRequestHeaders?)
    case delete(url: String, body: ApiRequestBody, headers: ApiRequestHeaders?)

    func method() -> String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

public protocol ApiClient {
    func httpRequestAsync(_ request: ApiRequest) async throws -> Data
    func httpRequest(_ request: ApiRequest, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)

    func getFile(from url: String,
                 progress: ((Double) -> Void)?,
                 completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
 }

extension ApiClient {
    public func httpRequestAsync(_ request: ApiRequest) async throws -> Data {
        try await withCheckedThrowingContinuation({ cont in
            self.httpRequest(request) { data, error in
                if let error = error {
                    cont.resume(throwing: error)
                    return
                }
                cont.resume(returning: data!)
            }
        })
    }
}

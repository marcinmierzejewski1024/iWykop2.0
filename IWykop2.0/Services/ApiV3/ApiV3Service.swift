//
//  ApiV3.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 27/01/2023.
//

import Foundation
import Resolver
import Combine

typealias AuthorizeAppResponse = ApiResponse<AuthResponse>
struct AuthorizeAppRequestBody: Codable {
    let data: AuthorizeAppRequestBodyData
}
struct AuthorizeAppRequestBodyData: Codable {
    let key: String
    let secret: String
}

protocol ApiV3AuthProtocol {
    func authorizeApp() throws -> AnyPublisher<AuthorizeAppResponse, APIError>
}

typealias EntriesListResponse = ApiResponse<[Entry]>

protocol EntryListProtocol {
    func getEntries() throws -> AnyPublisher<EntriesListResponse, APIError>
}

class ApiV3Service: Resolving {
    static let baseURL = "https://wykop.pl/api/v3/"
    private let creditentialProvider: ApiV3CreditentialsProviderProtocol
    private let dataTaskProvider: DataTaskPublisherProviderProtocol
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    lazy var tokenManager = TokenManager(authService: self)
    
    init(creditentialProvider: ApiV3CreditentialsProviderProtocol, dataTaskProvider: DataTaskPublisherProviderProtocol) {
        self.creditentialProvider = creditentialProvider
        self.dataTaskProvider = dataTaskProvider
    }
    
    func urlFor(path: String) throws -> URL {
        if let url = URL(string: Self.baseURL + path) {
            return url
        }
        throw APIError.invalidURL
    }
    
    func setupRequestHeaders(for request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        //refactor with combine
        if let token = tokenManager.getLocalToken() {
            request.setValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        }
    }
}

extension ApiV3Service: ApiV3AuthProtocol {
    func authorizeApp() throws -> AnyPublisher<AuthorizeAppResponse, APIError> {
        var urlRequest = try URLRequest(url: urlFor(path: "auth"))
        urlRequest.httpMethod = "POST"
        let data = AuthorizeAppRequestBodyData(key: creditentialProvider.keyAndSecret.0,
                                           secret: creditentialProvider.keyAndSecret.1)
        let body = AuthorizeAppRequestBody(data: data)
        urlRequest.httpBody = try jsonEncoder.encode(body)
        setupRequestHeaders(for: &urlRequest)
        return dataTaskProvider.taskPublisher(request: urlRequest).tryMap({ (data: Data, response: URLResponse) in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (httpResponse.statusCode / 100) == 2 else {
                throw APIError.code(httpResponse.statusCode)
            }
            
            return data
        }).decode(type: AuthorizeAppResponse.self, decoder: jsonDecoder).mapError { error in
            guard let apiError = error as? APIError else {
                print(error)
                return .other(error)
            }
            
            return apiError
        }.map({ response in
            
            if let token = response.data?.token {
                self.tokenManager.saveToken(token)
            }
            return response
        }).eraseToAnyPublisher()
    }
}

//refactor with combine
extension ApiV3Service: EntryListProtocol {
    func getEntries() throws -> AnyPublisher<EntriesListResponse, APIError> {
        var urlRequest = try URLRequest(url: urlFor(path: "entries?page=1"))
        setupRequestHeaders(for: &urlRequest)
        
        return dataTaskProvider.taskPublisher(request: urlRequest).tryMap({ (data: Data, response: URLResponse) in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (httpResponse.statusCode / 100) == 2 else {
                throw APIError.code(httpResponse.statusCode)
            }
            
            return data
        }).decode(type: EntriesListResponse.self, decoder: jsonDecoder).mapError { error in
            guard let apiError = error as? APIError else {
                print(error)
                return .other(error)
            }
            
            return apiError
        }.eraseToAnyPublisher()
    }
}

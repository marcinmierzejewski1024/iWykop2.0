//
//  TokenManager.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 31/01/2023.
//

import Foundation
import Combine

struct JWTToken {
    let token: String
    
    var isTokenValid: Bool {
        let components = token.components(separatedBy: ".")
        guard components.count == 3, let payloadData = Data(base64Encoded: components[1]) else {
            return false
        }
        
        guard let payload = try? JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any] else {
            return false
        }
        
        guard let expirationTimestamp = payload["exp"] as? Double else {
            return false
        }

        return Date().timeIntervalSince1970 < expirationTimestamp
    }
}

protocol TokenManagerProtocol {
    func withValidToken(completion: @escaping ((Result<JWTToken, Error>) -> Void))
    func saveToken(_ stringValue: String)
}

class TokenManager: TokenManagerProtocol {
    enum Constants {
        static let authTokenKey = "authTokenKey"
    }

    private var disposeBag = Set<AnyCancellable>()
    private let persistance = UserDefaultsPersistance()
    private let authService: ApiV3Service
    
    init(authService: ApiV3Service) {
        self.authService = authService
    }
    
    func withValidToken(completion: @escaping ((Result<JWTToken, Error>) -> Void)) {
        if let localToken = getLocalToken(), localToken.isTokenValid {
            completion(Result.success(localToken))
            return
        }
        
        do {
            try authService.authorizeApp().sink { result in
                
            } receiveValue: { [weak self] response in
                self?.persistance.setObject(response.data?.token, for: Constants.authTokenKey)
                
                if let localToken = self?.getLocalToken() {
                    completion(Result.success(localToken))
                } else {
                    completion(Result.failure(APIError.invalidResponse))
                }
            }.store(in: &disposeBag)
        } catch {
            print(error)
            completion(Result.failure(error))
            return
        }

    }
    
    func getLocalToken() -> JWTToken? {
        guard let authToken: String = persistance.object(for: Constants.authTokenKey) else {
            return nil
        }
        
        return JWTToken(token: authToken)
    }
    
    func saveToken(_ stringValue: String) {
        persistance.setObject(stringValue, for: Constants.authTokenKey)
    }
}

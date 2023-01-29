//
//  DataTaskPublisher.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 29/01/2023.
//

import Foundation


protocol DataTaskPublisherProviderProtocol {
    func taskPublisher(request: URLRequest) -> URLSession.DataTaskPublisher
}

final class DataTaskPublisherProvider: DataTaskPublisherProviderProtocol {
    func taskPublisher(request: URLRequest) -> URLSession.DataTaskPublisher {
        let session = URLSession.shared
        return session.dataTaskPublisher(for: request)
    }
}

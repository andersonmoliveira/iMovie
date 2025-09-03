//
//  NetworkingMock.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation
import CoreNetwork

final class NetworkingMock: NetworkingProtocol {

    var decodableToReturn: Decodable?
    var dataToReturn: Data?
    var errorToThrow: APIError?

    func request<T: Decodable>(_ request: Request) async throws -> T {
        if let error = errorToThrow {
            throw error
        }
        guard let result = decodableToReturn as? T else {
            throw APIError.decoding
        }
        return result
    }

    func request(_ request: Request) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? Data()
    }
}

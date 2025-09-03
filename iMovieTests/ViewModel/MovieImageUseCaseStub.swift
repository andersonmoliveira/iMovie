//
//  MovieImageUseCaseStub.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation
@testable import iMovie

final class MovieImageUseCaseStub: MovieImageUseCaseProtocol {
    var dataToReturn: Data = Data()
    var errorToThrow: MovieError?

    func execute(image name: String) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn
    }
}

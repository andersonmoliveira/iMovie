//
//  MovieUseCaseStub.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

@testable import iMovie

final class MovieUseCaseStub: MovieUseCaseProtocol {
    var moviesToReturn: [Movie] = []
    var errorToThrow: MovieError?

    func execute(page: Int) async throws -> [Movie] {
        if let error = errorToThrow {
            throw error
        }
        return moviesToReturn
    }
}

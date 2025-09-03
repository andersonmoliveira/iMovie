//
//  MovieServiceStub.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation
@testable import iMovie

final class MovieServiceStub: MovieServiceProtocol {
    var dataToReturn: Data = Data()
    var moviesToReturn: [Movie] = []
    var errorToThrow: MovieError?

    func getMovie(with page: Int) async throws -> [Movie] {
        if let error = errorToThrow {
            throw error
        }
        return moviesToReturn
    }

    func getMovieImage(from imageName: String) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn
    }
}

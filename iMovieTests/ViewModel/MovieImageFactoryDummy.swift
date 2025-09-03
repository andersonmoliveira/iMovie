//
//  MovieImageFactoryDummy.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation
@testable import iMovie

final class MovieImageViewModelDummy: MovieImageViewModelProtocol {
    func loadImage(name: String) async throws -> Data {
        return Data()
    }
}

final class MovieImageFactoryDummy: MovieImageFactoryProtocol {
    func makeImageViewModel() -> MovieImageViewModelProtocol {
        return MovieImageViewModelDummy()
    }
}

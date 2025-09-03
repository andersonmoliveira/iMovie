//
//  MovieUseCaseProtocol.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

protocol MovieUseCaseProtocol {
    func execute(page: Int) async throws -> [Movie]
}

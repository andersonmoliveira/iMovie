//
//  MovieImageUseCase.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation

class MovieImageUseCase: MovieImageUseCaseProtocol {
    
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func execute(image name: String) async throws -> Data {
        try await service.getMovieImage(from: name)
    }
}

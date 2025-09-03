//
//  MovieUseCase.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

class MovieUseCase: MovieUseCaseProtocol {
    
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func execute(page: Int) async throws -> [Movie] {
        try await service.getMovie(with: page)
    }
}

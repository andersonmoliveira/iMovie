//
//  MovieImageViewModel.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation

final class MovieImageViewModel: MovieImageViewModelProtocol {

    private let useCase: MovieImageUseCaseProtocol
    
    init(useCase: MovieImageUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadImage(name: String) async throws -> Data {
        try await useCase.execute(image: name)
    }
}

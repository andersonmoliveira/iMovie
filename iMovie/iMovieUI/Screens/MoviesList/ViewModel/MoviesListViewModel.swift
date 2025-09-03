//
//  MoviesListViewModel.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import UIKit

final class MoviesListViewModel: MoviesListViewModelProtocol {

    private let useCase: MovieUseCaseProtocol
    let movieImageFactory: MovieImageFactoryProtocol

    init(useCase: MovieUseCaseProtocol,
         movieImageFactory: MovieImageFactoryProtocol) {
        self.useCase = useCase
        self.movieImageFactory = movieImageFactory
    }

    func fetchMovies(page: Int) async throws -> [Movie] {
        return try await useCase.execute(page: page)
    }
}

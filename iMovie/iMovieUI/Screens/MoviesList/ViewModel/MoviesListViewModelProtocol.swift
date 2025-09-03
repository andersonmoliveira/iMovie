//
//  MoviesListViewModelProtocol.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

protocol MoviesListViewModelProtocol {
    var movieImageFactory: MovieImageFactoryProtocol { get }
    func fetchMovies(page: Int) async throws -> [Movie]
}

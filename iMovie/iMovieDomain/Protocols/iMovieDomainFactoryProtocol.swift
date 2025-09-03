//
//  iMovieDomainFactoryProtocol.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

protocol iMovieDomainFactoryProtocol {
    func makeMovieUseCase() -> MovieUseCaseProtocol
    func makeImageUseCase() -> MovieImageUseCaseProtocol
}

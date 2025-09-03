//
//  iMovieDomainFactory.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

class iMovieDomainFactory: iMovieDomainFactoryProtocol {
    
    private let factory: iMovieServiceFactoryProtocol
    
    init(factory: iMovieServiceFactoryProtocol) {
        self.factory = factory
    }

    func makeMovieUseCase() -> MovieUseCaseProtocol {
        return MovieUseCase(service: factory.makeMovieService())
    }

    func makeImageUseCase() -> MovieImageUseCaseProtocol {
        return MovieImageUseCase(service: factory.makeMovieService())
    }
}

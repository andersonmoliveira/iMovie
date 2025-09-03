//
//  MovieImageFactory.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

class MovieImageFactory: MovieImageFactoryProtocol {
    
    private let factory: iMovieDomainFactoryProtocol
    
    init(factory: iMovieDomainFactoryProtocol) {
        self.factory = factory
    }

    func makeImageViewModel() -> any MovieImageViewModelProtocol {
        MovieImageViewModel(useCase: factory.makeImageUseCase())
    }
}

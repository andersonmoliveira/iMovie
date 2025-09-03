//
//  iMovieUIFactory.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

class iMovieUIFactory: iMovieUIFactoryProtocol {
    
    private let factory: iMovieDomainFactoryProtocol
    private let movieImageFactory: MovieImageFactoryProtocol
    
    init(factory: iMovieDomainFactoryProtocol,
         movieImageFactory: MovieImageFactoryProtocol) {
        self.factory = factory
        self.movieImageFactory = movieImageFactory
    }

    func makeMoviesListViewController() -> MoviesListViewControllerProtocol {
        return MoviesListViewController(viewModel: makeMoviesListViewModel())
    }

    private func makeMoviesListViewModel() -> MoviesListViewModelProtocol {
        return MoviesListViewModel(useCase: factory.makeMovieUseCase(),
                                   movieImageFactory: movieImageFactory)
    }
}

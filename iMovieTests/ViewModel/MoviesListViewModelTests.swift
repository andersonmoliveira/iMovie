//
//  MoviesListViewModelTests.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import XCTest
@testable import iMovie

final class MoviesListViewModelTests: XCTestCase {

    private var sut : MoviesListViewModel!
    private var useCaseStub: MovieUseCaseStub!
    
    override func setUp() {
        super.setUp()
        useCaseStub = MovieUseCaseStub()
        let factoryDummy = MovieImageFactoryDummy()
        sut = MoviesListViewModel(useCase: useCaseStub, movieImageFactory: factoryDummy)
    }
    
    override func tearDown() {
        super.tearDown()
        useCaseStub = nil
        sut = nil
    }
    
    func testFetchMovies_Success() async throws {
        // Given
        let expectedMovies = [
            Movie(id: 1,
                  posterPath: "Filme 1",
                  backdropPath: nil,
                  title: nil,
                  overview: nil,
                  releaseDate: nil),
            Movie(id: 2,
                  posterPath: "Filme 2",
                  backdropPath: nil,
                  title: nil,
                  overview: nil,
                  releaseDate: nil),
        ]
        useCaseStub.moviesToReturn = expectedMovies
        
        // When
        let movies = try await sut.fetchMovies(page: 1)
        
        // Then
        XCTAssertEqual(movies.count, expectedMovies.count)
        XCTAssertEqual(movies.first?.title, expectedMovies.first?.title)
    }
    
    func testFetchMovies_ServiceUnavailableError() async throws {
        // Given
        useCaseStub.errorToThrow = .serviceUnavailable
        
        // When / Then
        do {
            _ = try await sut.fetchMovies(page: 1)
            XCTFail("Esperado que o execute lance o erro de serviço indisponível")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.serviceUnavailable)
        }
    }
    
    func testFetchMovies_UnexpectedError() async throws {
        // Given
        
        useCaseStub.errorToThrow = .unexpected
        
        // When / Then
        do {
            _ = try await sut.fetchMovies(page: 1)
            XCTFail("Esperado que o execute lance o erro inesperado")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.unexpected)
        }
    }
}

//
//  MovieUseCaseTests.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import XCTest
@testable import iMovie

final class MovieUseCaseTests: XCTestCase {

    private var sut: MovieUseCase!
    private var serviceStub: MovieServiceStub!
    
    override func setUp() {
        super.setUp()
        serviceStub = MovieServiceStub()
        sut = MovieUseCase(service: serviceStub)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        serviceStub = nil
    }
    
    // MARK: - Tests
    func testExecute_Success() async throws {
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
                  releaseDate: nil)
        ]
        serviceStub.moviesToReturn = expectedMovies
        
        // When
        let movies = try await sut.execute(page: 1)
        
        // Then
        XCTAssertEqual(movies.count, expectedMovies.count)
        XCTAssertEqual(movies.first?.title, expectedMovies.first?.title)
    }

    func testExecute_ServiceUnavailableError() async throws {
        // Given
        serviceStub.errorToThrow = .serviceUnavailable
        
        // When / Then
        do {
            _ = try await sut.execute(page: 1)
            XCTFail("Esperado que o execute lance o erro de serviço indisponível")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.serviceUnavailable)
        }
    }
    
    func testExecute_UnexpectedError() async throws {
        // Given
        serviceStub.errorToThrow = .unexpected
        
        // When / Then
        do {
            _ = try await sut.execute(page: 1)
            XCTFail("Esperado que o execute lance o erro inesperado")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.unexpected)
        }
    }
}

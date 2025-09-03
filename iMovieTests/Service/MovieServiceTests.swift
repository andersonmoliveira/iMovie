//
//  MovieServiceTests.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import XCTest
import CoreNetwork
@testable import iMovie

final class MovieServiceTests: XCTestCase {

    private var sut: MovieService!
    private var networkingMock: NetworkingMock!
    
    override func setUp() {
        super.setUp()
        networkingMock = NetworkingMock()
        sut = MovieService(networking: networkingMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        networkingMock = nil
    }
    
    // MARK: - getMovie
    func testGetMovie_Success() async throws {
        // Given
        let movie = Movie(id: 1,
                          posterPath: "poster1",
                          backdropPath: nil,
                          title: nil,
                          overview: nil,
                          releaseDate: nil)
        let response = MovieResponse(results: [movie])
        networkingMock.decodableToReturn = response
        
        // When
        let movies = try await sut.getMovie(with: 1)
        
        // Then
        XCTAssertEqual(movies.count, 1)
        XCTAssertEqual(movies.first?.posterPath, movie.posterPath)
    }
    
    func testGetMovie_ErrorNetwork() async throws {
        // Given
        networkingMock.errorToThrow = .network(NSError(domain: "", code: 0))
        
        // When / Then
        do {
            _ = try await sut.getMovie(with: 1)
            XCTFail("Esperado que getMovie lance erro de serviço indisponível")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.serviceUnavailable)
        }
    }
    
    func testGetMovie_ErrorDecoding() async throws {
        // Given
        networkingMock.errorToThrow = .decoding
        
        // When / Then
        do {
            _ = try await sut.getMovie(with: 1)
            XCTFail("Esperado que getMovie lance erro inesperado")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.unexpected)
        }
    }
    
    // MARK: - getMovieImage
    func testGetMovieImage_Success() async throws {
        // Given
        let imageData = "dummyData".data(using: .utf8)
        networkingMock.dataToReturn = imageData
        
        // When
        let data = try await sut.getMovieImage(from: "poster1")
        
        // Then
        XCTAssertEqual(data, imageData)
    }
    
    func testGetMovieImage_ErrorNetwork() async throws {
        // Given
        networkingMock.errorToThrow = .network(NSError(domain: "", code: 0))
        
        // When / Then
        do {
            _ = try await sut.getMovieImage(from: "poster1")
            XCTFail("Esperado que getMovieImage lance erro de serviço indisponível")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.serviceUnavailable)
        }
    }
    
    func testGetMovieImage_ErrorDecoding() async throws {
        // Given
        networkingMock.errorToThrow = .decoding
        
        // When / Then
        do {
            _ = try await sut.getMovieImage(from: "poster1")
            XCTFail("Esperado que getMovieImage lance erro inesperado")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.unexpected)
        }
    }
}

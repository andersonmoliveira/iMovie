//
//  MovieImageViewModelTests.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import XCTest
@testable import iMovie

final class MovieImageViewModelTests: XCTestCase {

    private var sut: MovieImageViewModel!
    private var useCaseStub: MovieImageUseCaseStub!

    override func setUp() {
        super.setUp()
        useCaseStub = MovieImageUseCaseStub()
        sut = MovieImageViewModel(useCase: useCaseStub)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        useCaseStub = nil
    }

    // MARK: - Tests
    func testLoadImage_Success() async throws {
        // Given
        let expectedData = "dummyImageData".data(using: .utf8)
        useCaseStub.dataToReturn = expectedData!

        // When
        let data = try await sut.loadImage(name: "poster1")

        // Then
        XCTAssertEqual(data, expectedData)
    }

    func testLoadImage_ServiceUnavailableError() async throws {
        // Given
        useCaseStub.errorToThrow = .serviceUnavailable

        // When / Then
        do {
            _ = try await sut.loadImage(name: "poster1")
            XCTFail("Esperado que loadImage lance o erro de serviço indisponível")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.serviceUnavailable)
        }
    }

    func testLoadImage_UnexpectedError() async throws {
        // Given
        useCaseStub.errorToThrow = .unexpected

        // When / Then
        do {
            _ = try await sut.loadImage(name: "poster1")
            XCTFail("Esperado que loadImage lance o erro inesperado")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.unexpected)
        }
    }
}

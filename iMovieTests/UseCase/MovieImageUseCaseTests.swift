//
//  Untitled.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import XCTest
@testable import iMovie

final class MovieImageUseCaseTests: XCTestCase {

    private var sut: MovieImageUseCase!
    private var serviceStub: MovieServiceStub!
    
    override func setUp() {
        super.setUp()
        serviceStub = MovieServiceStub()
        sut = MovieImageUseCase(service: serviceStub)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        serviceStub = nil
    }
    
    // MARK: - Tests
    func testExecute_Success() async throws {
        // Given
        let expectedData = "dummyImageData".data(using: .utf8)
        serviceStub.dataToReturn = expectedData!
        
        // When
        let data = try await sut.execute(image: "poster1")
        
        // Then
        XCTAssertEqual(data, expectedData)
    }
    
    func testExecute_ServiceUnavailableError() async throws {
        // Given
        serviceStub.errorToThrow = .serviceUnavailable
        
        // When / Then
        do {
            _ = try await sut.execute(image: "poster1")
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
            _ = try await sut.execute(image: "poster1")
            XCTFail("Esperado que o execute lance o erro inesperado")
        } catch {
            XCTAssertEqual(error as? MovieError, MovieError.unexpected)
        }
    }
}

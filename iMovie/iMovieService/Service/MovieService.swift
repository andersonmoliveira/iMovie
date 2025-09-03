//
//  MovieService.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation
import CoreNetwork

final class MovieService: MovieServiceProtocol {

    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }

    func getMovie(with page: Int) async throws -> [Movie] {
        let request = MovieRequest.trending(page: page)
        do {
            let response: MovieResponse = try await networking.request(request)
            return response.results
        } catch let error {
            throw mapNetworking(error as? APIError)
        }
    }
    
    func getMovieImage(from imageName: String) async throws -> Data {
        let request = ImageRequest.download(name: imageName)
        do {
            return try await networking.request(request)
        } catch let error {
            print(error)
            throw mapNetworking(error as? APIError)
        }
    }

    private func mapNetworking(_ error: APIError?) -> MovieError {
        switch error {
        case .network:
            return .serviceUnavailable
            
        case .invalidURL, .decoding, .noData:
            return .unexpected
        case .none:
            return .unexpected
        }
    }
}

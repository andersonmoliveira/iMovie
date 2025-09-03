//
//  iMovieServiceFactory.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import CoreNetwork

class iMovieServiceFactory: iMovieServiceFactoryProtocol {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }

    func makeMovieService() -> MovieServiceProtocol {
        return MovieService(networking: networking)
    }
}

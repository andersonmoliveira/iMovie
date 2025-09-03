//
//  MovieServiceProtocol.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation
import CoreNetwork

protocol MovieServiceProtocol {
    
    func getMovie(with page: Int) async throws -> [Movie]
    func getMovieImage(from imageName: String) async throws -> Data
}

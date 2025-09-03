//
//  MovieImageUseCaseProtocol.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation

protocol MovieImageUseCaseProtocol {
    func execute(image name: String) async throws-> Data
}

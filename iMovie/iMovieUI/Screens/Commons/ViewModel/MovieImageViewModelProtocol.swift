//
//  MovieImageViewModelProtocol.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import Foundation

protocol MovieImageViewModelProtocol {
    func loadImage(name: String) async throws -> Data
}

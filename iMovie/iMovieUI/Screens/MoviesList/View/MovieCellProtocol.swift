//
//  MovieCellProtocol.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import UIKit

protocol MovieCellProtocol where Self: UICollectionViewCell {
    var viewModel: MovieImageViewModelProtocol? { get set }
    func setupView(movie: Movie)
}

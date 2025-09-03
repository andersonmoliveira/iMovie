//
//  MovieCell.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import UIKit
import CoreUIKit

final class MovieCell: UICollectionViewCell, MovieCellProtocol {

    var viewModel: MovieImageViewModelProtocol?
    var currentPath: String = ""

    private lazy var cardView: CardViewProtocol = {
        let cardView = CardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 16
        cardView.placeholderImage = UIImage(named: "default_movie_poster")
        return cardView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView.asView())

        NSLayoutConstraint.activate([
            cardView.asView().topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.asView().leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.asView().trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.asView().bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        currentPath = ""
    }

    func setupView(movie: Movie) {
        cardView.setupView(
            poster: nil,
            title: movie.title ?? "",
            releaseDate: ""
        )
        loadImage(movie: movie)
    }

    private func loadImage(movie: Movie) {
        guard let posterPath = movie.posterPath else { return }
        cardView.startLoading()
        currentPath = posterPath
        Task {
            do {
                let imageData = try await viewModel?.loadImage(name: posterPath)
                updateView(data: imageData, posterPath: posterPath)
            } catch {
                cardView.setupView(
                    poster: nil,
                    title: movie.title ?? "",
                    releaseDate: ""
                )
            }
        }
    }

    private func updateView(data: Data?, posterPath: String) {
        guard currentPath == posterPath else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self, let data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.cardView.update(image: image)
            }
        }
    }
}

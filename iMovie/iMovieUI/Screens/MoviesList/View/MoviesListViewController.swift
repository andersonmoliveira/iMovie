//
//  MoviesListViewController.swift
//  iMovie
//
//  Created by Anderson Oliveira on 28/08/25.
//

import UIKit

final class MoviesListViewController: UIViewController, MoviesListViewControllerProtocol {
    private var movies: [Movie] = []
    private var currentPage = 1
    private var isLoading = false
    private var hasMorePages = true

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresh
    }()

    private let viewModel: MoviesListViewModelProtocol

    init(viewModel: MoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        getMovies(page: currentPage)
    }

    private func getMovies(page: Int) {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            do {
                let newMovies = try await viewModel.fetchMovies(page: page)
                updateView(with: newMovies)
                if newMovies.isEmpty {
                    hasMorePages = false
                }
            } catch {
                let apiError = error as? MovieError
                showErrorAlert(message: apiError?.errorDescription ?? "Ocorreu um erro ao carregar os filmes.")
                refreshControl.endRefreshing()
            }
            isLoading = false
        }
    }

    @MainActor
    private func updateView(with newMovies: [Movie]) {
        if currentPage == 1 {
            movies = newMovies
            refreshControl.endRefreshing()
        } else {
            movies.append(contentsOf: newMovies)
        }
        collectionView.reloadData()
    }

    @MainActor
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc
    private func handleRefresh() {
        currentPage = 1
        hasMorePages = true
        getMovies(page: currentPage)
    }

    private func registerCells() {
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: String(describing: MovieCell.self))
    }

    private func setupUI() {
        title = "Filmes"
        view.backgroundColor = .systemBackground
        collectionView.refreshControl = refreshControl
    }

    private func setupLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self),
                                                            for: indexPath) as? MovieCellProtocol,
              let movie = movies[safe: indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.movieImageFactory.makeImageViewModel()
        cell.setupView(movie: movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 + 16 + 8 // insets + espaçamento
        let availableWidth = collectionView.frame.width - padding
        let columns: CGFloat = 2
        let width = availableWidth / columns

        return CGSize(width: width, height: 285)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let threshold = movies.count - 4 // quando faltar 4 itens
        if indexPath.item == threshold, hasMorePages, !isLoading {
            currentPage += 1
            getMovies(page: currentPage)
        }
    }
}

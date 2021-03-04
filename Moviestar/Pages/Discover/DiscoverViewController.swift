//
//  DiscoverViewController.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit
import Entities

final class DiscoverViewController: UIViewController {
    
    private let contentView = DiscoverView()
    private let viewModel: DiscoverViewModel
    private let onMovieSelect: (Movie) -> Void
    private lazy var searchBar: UISearchBar = .init(frame: .zero)
    private typealias CellRegistration = UICollectionView.CellRegistration<MovieCell, MovieCell.ViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieCell.ViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieCell.ViewModel>

    enum Section {
        case movies
    }

    private lazy var dataSource: DataSource = {
        return DataSource(
            collectionView: contentView.collectionView,
            cellProvider: { (collectionView, indexPath, cellData) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(
                    using: CellRegistration { $0.populate(data: $2) },
                    for: indexPath,
                    item: cellData
                )
            }
        )
    }()

    init(viewModel: DiscoverViewModel, onMovieSelect: @escaping (Movie) -> Void) {
        self.viewModel = viewModel
        self.onMovieSelect = onMovieSelect
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupNavigationBar()
        viewModel.viewDidLoad()
        setupEmptyState()
    }

    override func loadView() {
        view = contentView
    }

    private func setupDelegates() {
        viewModel.delegate = self
        searchBar.delegate = self
        contentView.collectionView.delegate = self
    }

    private func setupNavigationBar() {
        searchBar.placeholder = "Search for movies..."
        navigationItem.titleView = searchBar
    }
    
    private func setupEmptyState() {
        contentView.emptyStateView.buttonAction = { [weak self] in
            self?.viewModel.viewDidLoad()
            self?.contentView.emptyStateView.hide()
        }
    }
}

// MARK: DiscoverViewModel Delegate
extension DiscoverViewController: DiscoverViewModelDelegate {
    func discoverViewModel(_ viewModel: DiscoverViewModel, didLoad data: [MovieCell.ViewModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.movies])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
        if data.isEmpty {
            contentView.emptyStateView.show()
        } else {
            contentView.emptyStateView.hide()
        }
    }
}

// MARK: UISearchBar Delegate
extension DiscoverViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      guard let searchText = searchBar.text else { return }
      if searchText.count >= 2 {
        viewModel.searchPerformed(searchText)
        searchBar.resignFirstResponder()
      } else {
        let alert = UIAlertController(title: "Wrong input", message: "Too short for a query! Try to enter at least 2 characters.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
}

extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movieFor(indexPath: indexPath)
        onMovieSelect(movie)
    }
}

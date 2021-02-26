//
//  DiscoverViewController.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit

final class DiscoverViewController: UIViewController {
    private let contentView = DiscoverView()
    private let viewModel: DiscoverViewModel
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

    init(viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
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
    }

    override func loadView() {
        view = contentView
    }

    private func setupDelegates() {
        viewModel.delegate = self
        searchBar.delegate = self
    }

    private func setupNavigationBar() {
        searchBar.placeholder = "Search for movies..."
        navigationItem.titleView = searchBar
    }
}

// MARK: DiscoverViewModel Delegate
extension DiscoverViewController: DiscoverViewModelDelegate {
    func discoverViewModel(_ viewModel: DiscoverViewModel, didLoad data: [MovieCell.ViewModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.movies])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: UISearchBar Delegate
extension DiscoverViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

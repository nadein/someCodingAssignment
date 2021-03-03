//
//  AppCoordinator.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit
import Entities

final class AppCoordinator {
    private let session = Session()
    private let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let onMovieSelect = { movie in
            self.showDetails(movie)
        }
        let viewController = DiscoverViewController(viewModel: .init(session: session), onMovieSelect: onMovieSelect)
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showDetails(_ movie: Movie) {
        let viewController = DetailsViewController(viewModel: .init(movie: movie))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//
//  DiscoverViewModel.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation
import Entities
import API

protocol DiscoverViewModelDelegate: AnyObject {
    func discoverViewModel(_ viewModel: DiscoverViewModel, didLoad data: [MovieCell.ViewModel])
}

final class DiscoverViewModel {
    weak var delegate: DiscoverViewModelDelegate?
    private let session: Session

    private var movies: [Movie] = [] {
        didSet {
            delegate?.discoverViewModel(self, didLoad: movies.map { movie in
                return MovieCell.ViewModel(
                    id: movie.id,
                    title: movie.title
                )
            })
        }
    }

    init(session: Session) {
        self.session = session
    }

    func viewDidLoad() {
        Movie.getNowPlaying().response(using: session.client) { response in
            print("--- EXAMPLE: Movies that are now playing in theatres ---")
            dump(response)
            print("--- END OF EXAMPLE ---")
        }
    }
}

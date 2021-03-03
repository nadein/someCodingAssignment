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
            DispatchQueue.main.async {
                self.delegate?.discoverViewModel(self, didLoad: self.movies.map { movie in
                    return MovieCell.ViewModel(
                        id: movie.id,
                        title: movie.title,
                        posterPath: movie.posterPath
                    )
                })
            }
        }
    }

    init(session: Session) {
        self.session = session
    }
    
    func movieFor(indexPath: IndexPath) -> Movie {
        return movies[indexPath.item]
    }

    func viewDidLoad() {
        Movie.getNowPlaying().response(using: session.client) { [weak self] response in
            print("--- EXAMPLE: Movies that are now playing in theatres ---")
            dump(response)
            self?.movies = response.value?.results ?? []
            print("--- END OF EXAMPLE ---")
        }
    }
  
    func searchPerformed(_ query: String) {
        if query.count >= 2 {
            Movie.getSearchResults(query).response(using: session.client) { [weak self] response in
                print("--- SEARCH RESPONSE:  ---")
                dump(response)
                self?.movies = response.value?.results ?? []
                print("--- END OF SEARCH RESPONSE ---")
            }
        }
    }
}

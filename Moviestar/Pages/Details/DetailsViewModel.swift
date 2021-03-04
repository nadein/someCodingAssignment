//
//  DetailsViewModel.swift
//  Moviestar
//
//  Created by Alex Nadein on 02.03.2021.
//

import UIKit
import Entities

final class DetailsViewModel: NSObject {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func viewDidLoad(_ view: DetailsView) {
        view.populate(data: DetailsView.ViewModel(id: movie.id, title: movie.title, posterPath: movie.posterPath, overview: movie.overview))
    }
}

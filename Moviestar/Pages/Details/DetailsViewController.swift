//
//  DetailsViewController.swift
//  Moviestar
//
//  Created by Alex Nadein on 02.03.2021.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private let contentView = DetailsView()
    private let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        viewModel.viewDidLoad(contentView)
    }
    
    override func loadView() {
        view = contentView
    }
}

//
//  DetailsView.swift
//  Moviestar
//
//  Created by Alex Nadein on 02.03.2021.
//

import UIKit
import Kingfisher

final class DetailsView: UIView {
    let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .left
        this.textColor = UIColor.darkText
        this.numberOfLines = 0
        this.font = .boldSystemFont(ofSize: 20)
        return this
    }()
    
    let overviewText: UITextView = {
        let this = UITextView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .left
        this.textColor = UIColor.darkText
        this.isEditable = false
        this.font = .systemFont(ofSize: 20)
        return this
    }()
  
    let posterView: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.contentMode = .scaleAspectFit
        return this
    }()
    
    convenience init() {
        self.init(frame: .zero)
        configureView()
        configureSubviews()
        configureConstraints()
    }

    private func configureView() {
        backgroundColor = .white
    }

    private func configureSubviews() {
        self.addSubview(posterView)
        self.addSubview(titleLabel)
        self.addSubview(overviewText)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            posterView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            posterView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            posterView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            posterView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            posterView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: overviewText.topAnchor, constant: -8),
            
            overviewText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            overviewText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            overviewText.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 16),
        ])
    }
}

extension DetailsView {
    struct ViewModel: Hashable {
        let id: Int
        let title: String
        let posterPath: String?
        let overview: String
    }

    func populate(data: ViewModel) {
        titleLabel.text = data.title
        overviewText.text = data.overview
        if let posterPath = data.posterPath {
          let url = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
          posterView.kf.setImage(with: url)
        } else {
          posterView.image = #imageLiteral(resourceName: "moviePosterPlaceholder")
        }
    }
}

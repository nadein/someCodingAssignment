//
//  MovieCell.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit
import Kingfisher

final class MovieCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .left
        this.textColor = UIColor.white
        this.numberOfLines = 0
        this.font = .boldSystemFont(ofSize: 20)
        this.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        this.layer.cornerRadius = 3.0
        this.layer.masksToBounds = true
        return this
    }()
  
    let posterView: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.contentMode = .scaleAspectFill
        return this
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
        configureSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        contentView.backgroundColor = .systemGray3
        contentView.layer.cornerRadius = 18
        contentView.clipsToBounds = true
    }

    private func configureSubviews() {
        contentView.addSubview(posterView)
        contentView.addSubview(titleLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
          
            posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            posterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            posterView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
        ])
    }
}

extension MovieCell {
    struct ViewModel: Hashable {
        let id: Int
        let title: String
        let posterPath: String?
    }

    func populate(data: ViewModel) {
        titleLabel.text = data.title
        if let posterPath = data.posterPath {
          let url = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
          posterView.kf.setImage(with: url)
        } else {
          posterView.image = #imageLiteral(resourceName: "moviePosterPlaceholder")
        }
    }
}

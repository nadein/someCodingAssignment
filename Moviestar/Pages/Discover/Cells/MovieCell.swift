//
//  MovieCell.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .left
        this.textColor = UIColor.white.withAlphaComponent(0.5)
        this.numberOfLines = 0
        this.font = .boldSystemFont(ofSize: 20)
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
    }

    private func configureSubviews() {
        contentView.addSubview(titleLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}

extension MovieCell {
    struct ViewModel: Hashable {
        let id: Int
        let title: String
    }

    func populate(data: ViewModel) {
        titleLabel.text = data.title
    }
}

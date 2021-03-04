//
//  EmptyStateView.swift
//  Moviestar
//
//  Created by Alex Nadein on 04.03.2021.
//

import UIKit

class EmptyStateView: UIView {
    let label: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .center
        this.textColor = UIColor.darkText
        this.numberOfLines = 0
        this.font = .systemFont(ofSize: 20)
        this.text = "Nothing to display. Try another query\nor"
        return this
    }()
    let discoverButton: UIButton = {
        let this = UIButton()
        this.backgroundColor = .systemBlue
        this.layer.cornerRadius = 4.0
        this.clipsToBounds = true
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setTitle("Discover", for: .normal)
        this.addTarget(self, action: #selector(discoverButtonAction), for: .touchUpInside)
        return this
    }()
    
    var buttonAction: (() -> Void)?
    
    convenience init() {
        self.init(frame: .zero)
        configureView()
        configureSubviews()
        configureConstraints()
    }
    
    public func show() {
        self.isHidden = false
    }
    
    public func hide() {
        self.isHidden = true
    }
    
    private func configureView() {
        backgroundColor = .white
    }

    private func configureSubviews() {
        self.addSubview(label)
        self.addSubview(discoverButton)
    }
    
    
    @objc private func discoverButtonAction(sender: UIButton!) {
        buttonAction?()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            discoverButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            discoverButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            discoverButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

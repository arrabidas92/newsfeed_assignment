//
//  BottomFeedCell.swift
//  AssignmentBakara
//
//  Created by Alexandre DUARTE on 02/10/2021.
//

import UIKit
import Kingfisher

final class BottomFeedCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "BottomFeedCell"
    
    // MARK: - UI
    
    private let articleTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleDate: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public API
    
    func setArticle(
        title: String,
        date: String,
        description: String,
        imageURL: String
    ) {
        articleTitle.text = title
        articleDate.text = date
        articleDescription.text = description
        let url = URL(string: imageURL)!
        articleImage.kf.indicatorType = .activity
        articleImage.kf.setImage(with: url)
    }
    
    // MARK: - Private API
    
    private func configureCell() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(articleTitle)
        addSubview(articleDate)
        addSubview(articleDescription)
        addSubview(articleImage)
        
        articleTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        articleDate.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 8).isActive = true
        articleDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        articleDate.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -8).isActive = true
        
        articleDescription.topAnchor.constraint(equalTo: articleDate.bottomAnchor, constant: 8).isActive = true
        articleDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        articleDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        articleImage.topAnchor.constraint(equalTo: articleDescription.bottomAnchor, constant: 8).isActive = true
        articleImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        articleImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        articleImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

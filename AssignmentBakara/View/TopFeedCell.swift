//
//  TopFeedCell.swift
//  AssignmentBakara
//
//  Created by Alexandre DUARTE on 02/10/2021.
//

import UIKit
import Kingfisher

final class TopFeedCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "TopFeedCell"
    
    // MARK: - UI
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let image: UIImageView = {
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
    
    func setArticle(title: String, imageURL: String) {
        label.text = title
        let url = URL(string: imageURL)!
        image.kf.indicatorType = .activity
        image.kf.setImage(with: url)
    }
    
    // MARK: - Private API
    
    private func configureCell() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(label)
        addSubview(image)
        
        label.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

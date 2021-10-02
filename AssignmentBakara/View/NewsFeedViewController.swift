//
//  ViewController.swift
//  AssignmentBakara
//
//  Created by Alexandre DUARTE on 02/10/2021.
//

import UIKit
import Combine

final class NewsFeedViewController: UICollectionViewController {
    
    // MARK: - UI
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - ViewModel
    
    private let viewModel = NewsFeedViewModel()
    private var newsFeed: [Article] = []
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Life cycle
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News Feed"
        collectionView.backgroundColor = .white
        collectionView.register(BottomFeedCell.self, forCellWithReuseIdentifier: BottomFeedCell.identifier)
        collectionView.register(TopFeedCell.self, forCellWithReuseIdentifier: TopFeedCell.identifier)
    
        addLoadingIndicatorIntoUI()
        bindLoadingState()
        bindNewsFeed()
        viewModel.fetch()
    }
}

// MARK: - UICollectionViewDatasource

extension NewsFeedViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return newsFeed.isEmpty ? 0 : 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let newsFeedSection = NewsFeedSection(rawValue: section) else { return 0 }
        switch newsFeedSection {
        case .top:
            return newsFeed.isEmpty ? 0 : 6
        case .bottom:
            return newsFeed.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let newsFeedSection = NewsFeedSection(rawValue: indexPath.section) else { fatalError("Unknown section") }
        let news = newsFeed[indexPath.row]
        switch newsFeedSection {
        case .top:
            return getTopFeedCell(indexPath: indexPath, news: news)
        case .bottom:
            return getBottomFeedCell(indexPath: indexPath, news: news)
        }
    }
    
    private func getTopFeedCell(indexPath: IndexPath, news: Article) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFeedCell.identifier, for: indexPath) as? TopFeedCell else {
            fatalError("Not dequeuing a TopFeedCell")
        }
        
        cell.setArticle(title: news.title, imageURL: news.urlToImage)
        
        return cell
    }
    
    private func getBottomFeedCell(indexPath: IndexPath, news: Article) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomFeedCell.identifier, for: indexPath) as? BottomFeedCell else {
            fatalError("Not dequeuing a BottomFeedCell")
        }
        
        cell.setArticle(
            title: news.title,
            date: news.formattedPublishedAt,
            description: news.description,
            imageURL: news.urlToImage
        )
        
        return cell
    }
}

// MARK: - ViewModel Bindings

extension NewsFeedViewController {
    private func bindLoadingState() {
        viewModel.$isLoading.sink { isLoading in
            if isLoading {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
        }.store(in: &cancellables)
    }
    
    private func bindNewsFeed() {
        viewModel.$news.sink { [weak self] in
            self?.render($0)
        }.store(in: &cancellables)
    }
}

// MARK: - UI Setup

extension NewsFeedViewController {
    private func render(_ newsFeed: [Article]) {
        guard !newsFeed.isEmpty else { return }
        self.newsFeed = newsFeed
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            guard let newsFeedSection = NewsFeedSection(rawValue: sectionNumber) else { return nil }
            switch newsFeedSection {
            case .top:
                return self.getTopFeedLayout()
            case .bottom:
                return self.getBottomFeedLayout()
            }
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
    
    private func getTopFeedLayout(inset: CGFloat = 16) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(300)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets.leading = inset
        section.contentInsets.trailing = inset
        section.contentInsets.top = inset
        section.contentInsets.bottom = inset
        section.interGroupSpacing = inset
        
        return section
    }
    
    private func getBottomFeedLayout(inset: CGFloat = 16) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(CGFloat(newsFeed.count * 400))
            ),
            subitem: item,
            count:  newsFeed.count
        )
        group.interItemSpacing = .fixed(inset)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = inset
        section.contentInsets.trailing = inset
        
        return section
    }
    
    private func addLoadingIndicatorIntoUI() {
        view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

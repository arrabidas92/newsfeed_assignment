//
//  NewsFeedViewModel.swift
//  AssignmentBakara
//
//  Created by Alexandre DUARTE on 02/10/2021.
//

import Foundation
import Combine

final class NewsFeedViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var news: [Article] = []

    func fetch() {
        guard let url = URL(string: "https://saurav.tech/NewsAPI/everything/cnn.json") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let newsFeed = try? JSONDecoder().decode(NewsFeed.self, from: data) else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                self.news = newsFeed.articles
                    .sorted(by: { $0.isoPublishedAt.compare($1.isoPublishedAt) == .orderedDescending })
            }
        }
        task.resume()
    }
}

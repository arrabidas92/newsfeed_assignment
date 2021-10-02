//
//  NewsFeedModel.swift
//  AssignmentBakara
//
//  Created by Alexandre DUARTE on 02/10/2021.
//

import Foundation

struct NewsFeed : Codable {
    let articles : [Article]

    enum CodingKeys: String, CodingKey {
        case articles
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decode([Article].self, forKey: .articles)
    }
}

//
//  Article.swift
//  AssignmentBakara
//
//  Created by Alexandre DUARTE on 02/10/2021.
//

import Foundation

struct Article : Codable {
    let title : String
    let description : String
    let urlToImage : String
    let publishedAt : String

    var isoPublishedAt: Date {
        return DateFormatter.isoDateFormatter.date(from: publishedAt)!
    }
    
    var formattedPublishedAt: String {
        return DateFormatter.displayedDateFormatter.string(from: isoPublishedAt)
    }
}

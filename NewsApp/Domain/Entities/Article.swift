//
//  Article.swift
//  NewsApp
//
//  Created by tarek ahmed on 21/06/2024.
//

import Foundation


struct ArticleResponse {
    var articles: [Article]
}

struct Article: Identifiable , Hashable {
    var id = UUID()
    let title: String
    let author: String
    let description: String
    let publishedAt: String
    let content: String
    let sourceName: String
    let url: String
    let urlToImage: String
}

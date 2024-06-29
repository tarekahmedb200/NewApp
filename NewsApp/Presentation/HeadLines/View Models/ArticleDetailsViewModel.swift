//
//  ArticleDetailsViewModel.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation

class ArticleDetailsViewModel {
    
    var title: String
    var hoursAgo: String?
    var posterImagePathUrl: URL?
    let author: String
    let description: String
    let content: String
    let url: URL?
   
    init(article: Article) {
        self.title = article.title
        if let publishedDate = article.publishedAt.toDate(withFormat: .fullFormat),
           let hoursDiff = Date.getDifferenceBetweenDate(oldDate: publishedDate, newDate: Date(), with: [.hour]).hour {
            self.hoursAgo = "\(hoursDiff) hours ago"
        }
        self.posterImagePathUrl = URL(string: article.urlToImage)
        self.author = article.author + ", " + article.sourceName
        self.description = article.description
        self.content = article.content
        self.url = URL(string:article.url) 
    }
    
}


//
//  SearchItemViewModel.swift
//  NewsApp
//
//  Created by tarek ahmed on 26/06/2024.
//

import Foundation

class SearchItemViewModel {
    
    var title: String
    var source: String
    var publishedDate: String?
    var posterImagePathUrl: URL?
    
    init(article: Article) {
        self.title = article.title
        self.source = article.sourceName
        if let publishedDate = article.publishedAt.toDate(withFormat: .fullFormat) {
            self.publishedDate = publishedDate.toString(withFormat: .medium)
        }
        self.posterImagePathUrl = URL(string: article.urlToImage)
    }
    
}

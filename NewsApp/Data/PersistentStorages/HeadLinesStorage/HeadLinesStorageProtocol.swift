//
//  HeadLinesStorageProtocol.swift
//  NewsApp
//
//  Created by tarek ahmed on 24/06/2024.
//

import Foundation

protocol HeadLinesStorageProtocol {
    func fetchArticles() throws -> [ArticleDTO]
    func save(articles: [ArticleDTO])
    func deleteAllArticles()
}

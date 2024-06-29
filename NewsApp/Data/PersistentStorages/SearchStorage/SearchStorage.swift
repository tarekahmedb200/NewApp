//
//  SearchStorageProtocol.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation

protocol SearchStorage {
    func fetchSearchedArticles(word:String) throws -> [ArticleDTO]
    func save(word:String,searchedArticles: [ArticleDTO])
    func deleteAllArticles(word:String)
}

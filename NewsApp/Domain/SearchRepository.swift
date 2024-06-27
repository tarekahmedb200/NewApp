//
//  SearchRepository.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation

import Combine

protocol SearchRepository {
    func fetchSearchedArticles(word:String,page:Int) -> AnyPublisher<ArticleResponseDTO, Error>
}

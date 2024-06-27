//
//  SearchRepositoryMock.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 26/06/2024.
//

import Foundation
import Combine
@testable import NewsApp

class SearchRepositoryMock {
    private var searchService : SearchServiceMock
    private var cache : SearchStorageProtocol
    private var networkReachabilityManager : NetworkReachabilityMock
    
    init(searchService: SearchServiceMock,cache : SearchStorageProtocol,
        networkReachabilityManager : NetworkReachabilityMock) {
        self.searchService = searchService
        self.cache = cache
        self.networkReachabilityManager = networkReachabilityManager
    }
}

extension SearchRepositoryMock : SearchRepository {
    
    
    func fetchSearchedArticles(word: String, page: Int) -> AnyPublisher<ArticleResponseDTO, any Error> {
        do {
            
            if !networkReachabilityManager.isReachable {
                let articles = try cache.fetchSearchedArticles(word: word)
                let articleResponsDto = ArticleResponseDTO(articles: articles)
                return Just(articleResponsDto)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            
            return searchService.search(word: word, page: page)
                .handleEvents(receiveOutput: { [weak self] articleResponseDTO in
                    let articles = articleResponseDTO.articles
                    self?.cache.save(word: word, searchedArticles: articles)
                })
                .eraseToAnyPublisher()
        }catch {
            print(error.localizedDescription)
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
    }
    
}





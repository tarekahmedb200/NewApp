//
//  DefaultSearchRepositoryImplmentation.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import Combine

class DefaultSearchRepositoryImplmentation {
    private var searchService : SearchServiceProtocol
    private var cache : SearchStorageProtocol
    private var networkReachabilityManager : NetworkReachabilityManager
    
    init(searchService : SearchServiceProtocol, cache: SearchStorageProtocol) {
        self.searchService = searchService
        self.cache = cache
        networkReachabilityManager = NetworkReachabilityManager()
        networkReachabilityManager.startMonitoring()
    }
}

extension DefaultSearchRepositoryImplmentation : SearchRepository {
   
    func fetchSearchedArticles(word:String,page:Int) -> AnyPublisher<ArticleResponseDTO, any Error> {
        
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
                    self?.cache.deleteAllArticles(word: word)
                    self?.cache.save(word:word,searchedArticles: articles)
                })
                .eraseToAnyPublisher()
        }catch {
            print(error.localizedDescription)
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
    }
}




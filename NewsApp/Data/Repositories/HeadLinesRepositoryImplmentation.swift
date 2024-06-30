//
//  DefaultHeadLinesRepositoryImplmentation.swift
//  NewsApp
//
//  Created by tarek ahmed on 22/06/2024.
//

import Foundation
import Combine

class HeadLinesRepositoryImplmentation {
    private var headLinesFetcherService: HeadLinesFetcherService
    private var cache: HeadLinesStorage
    private var networkReachabilityManager: NetworkReachabilityManager
    
    init(headLinesFetcherService : HeadLinesFetcherService,cahce:HeadLinesStorage) {
        self.headLinesFetcherService = headLinesFetcherService
        self.cache = cahce
        networkReachabilityManager = NetworkReachabilityManager()
        networkReachabilityManager.startMonitoring()
    }
}

extension HeadLinesRepositoryImplmentation : HeadLinesRepository {
    func fetchHeadLines() -> AnyPublisher<ArticleResponseDTO, any Error> {
        
        do {
            
            if !networkReachabilityManager.isReachable {
                let articles = try cache.fetchArticles()
                let articleResponsDto = ArticleResponseDTO(articles: articles)
                return Just(articleResponsDto)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            return headLinesFetcherService.fetchHeadLines()
                .handleEvents(receiveOutput: { [weak self] articleResponseDTO in
                    let articles = articleResponseDTO.articles
                    self?.cache.deleteAllHeadlines()
                    self?.cache.save(articles: articles)
                })
                .eraseToAnyPublisher()
        }catch {
            print(error.localizedDescription)
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
    }
}



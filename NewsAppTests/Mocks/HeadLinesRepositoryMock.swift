//
//  HeadLinesRepositoryMock.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import Combine
@testable import NewsApp

class HeadLinesRepositoryMock {
    private var headLinesFetcherService: HeadLinesFetcherServiceMock
    private var cache: HeadLinesStorage
    private var networkReachabilityManager: NetworkReachabilityMock
    
    init(headLinesFetcherService : HeadLinesFetcherServiceMock,cahce:HeadLinesStorage,
        networkReachabilityManager : NetworkReachabilityMock) {
        self.headLinesFetcherService = headLinesFetcherService
        self.cache = cahce
        self.networkReachabilityManager = networkReachabilityManager
    }
}

extension HeadLinesRepositoryMock : HeadLinesRepository {
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




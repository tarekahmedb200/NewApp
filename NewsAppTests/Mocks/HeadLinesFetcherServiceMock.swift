//
//  HeadLinesFetcherServiceMock.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import Combine
@testable import NewsApp


class HeadLinesFetcherServiceMock : HeadLinesFetcherServiceProtocol
{
    func fetchHeadLines() -> AnyPublisher<ArticleResponseDTO, any Error> {
        let articleResponse : ArticleResponseDTO? = MockJSONFetcher.readJSONFromFile(fileName: "HeadLinesMockData", fileType: "json")
        
        return Just(articleResponse ?? ArticleResponseDTO(articles: []))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}



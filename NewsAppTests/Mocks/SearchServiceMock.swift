//
//  SearchServiceMock.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 26/06/2024.
//

import Foundation
import Combine
@testable import NewsApp

class SearchServiceMock : SearchService {
    func search(word:String,page:Int) -> AnyPublisher<ArticleResponseDTO, any Error> {
        
        var articleResponse : ArticleResponseDTO? = MockJSONFetcher.readJSONFromFile(fileName: "SearchMockData", fileType: "json")
        
        var articlesDto = Array(articleResponse?.articles.prefix(page * 10) ?? [])
        
        return Just(ArticleResponseDTO(articles: articlesDto))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}

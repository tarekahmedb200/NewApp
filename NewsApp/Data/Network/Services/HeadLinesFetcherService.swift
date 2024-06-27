//
//  HeadLinesFetcherService.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import Combine

protocol HeadLinesFetcherServiceProtocol {
    func fetchHeadLines() -> AnyPublisher<ArticleResponseDTO,Error>
}

class HeadLinesFetcherService {
    private var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
}

extension HeadLinesFetcherService : HeadLinesFetcherServiceProtocol {
    func fetchHeadLines() -> AnyPublisher<ArticleResponseDTO,Error> {
        return self.apiManager.initRequest(with:  HeadLinesRequest.fetchHeadLines, type: ArticleResponseDTO.self)
    }
}



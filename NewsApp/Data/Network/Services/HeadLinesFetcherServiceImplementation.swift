//
//  HeadLinesFetcherService.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import Combine

protocol HeadLinesFetcherService {
    func fetchHeadLines() -> AnyPublisher<ArticleResponseDTO,Error>
}

class HeadLinesFetcherServiceImplementation {
    private var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
}

extension HeadLinesFetcherServiceImplementation : HeadLinesFetcherService {
    func fetchHeadLines() -> AnyPublisher<ArticleResponseDTO,Error> {
        return self.apiManager.initRequest(with:  HeadLinesRequest.fetchHeadLines, type: ArticleResponseDTO.self)
    }
}



//
//  SearchService.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import Combine

protocol SearchServiceProtocol {
    func search(word:String,page:Int) -> AnyPublisher<ArticleResponseDTO,Error>
}

class SearchService {
    private var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
}

extension SearchService : SearchServiceProtocol {
    func search(word:String,page:Int) -> AnyPublisher<ArticleResponseDTO,Error> {
        return self.apiManager.initRequest(with: SearchRequest.fetchEverthing(search: word, page: page), type: ArticleResponseDTO.self)
    }
}

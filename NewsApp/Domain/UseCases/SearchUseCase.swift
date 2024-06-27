//
//  SearchUseCase.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import Combine

protocol SearchUseCase {
    func execute(word:String,page:Int) -> AnyPublisher<ArticleResponseDTO, Error>
}

final class DefaultSearchUseCaseImplementation  {
    
    private let searchRepository: SearchRepository
  
    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
}

extension DefaultSearchUseCaseImplementation : SearchUseCase {
    func execute(word:String,page:Int) -> AnyPublisher<ArticleResponseDTO, any Error> {
        return self.searchRepository.fetchSearchedArticles(word: word, page: page)
    }
}

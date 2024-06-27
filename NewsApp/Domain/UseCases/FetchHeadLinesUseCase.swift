//
//  FetchHeadLinesUseCase.swift
//  NewsApp
//
//  Created by tarek ahmed on 22/06/2024.
//

import Foundation
import Combine

protocol FetchHeadLinesUseCaseProtocol {
    func execute() -> AnyPublisher<ArticleResponseDTO, Error>
}

final class DefaultFetchHeadLinesUseCaseImplementation  {
    
    private let headLinesRepository: HeadLinesRepository
  
    init(headLinesRepository: HeadLinesRepository) {
        self.headLinesRepository = headLinesRepository
    }
    
}

extension DefaultFetchHeadLinesUseCaseImplementation : FetchHeadLinesUseCaseProtocol {
    func execute() -> AnyPublisher<ArticleResponseDTO, any Error> {
        return self.headLinesRepository.fetchHeadLines()
    }
}




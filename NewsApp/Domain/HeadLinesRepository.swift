//
//  HeadLinesRepository.swift
//  NewsApp
//
//  Created by tarek ahmed on 22/06/2024.
//

import Foundation
import Combine

protocol HeadLinesRepository {
    func fetchHeadLines() -> AnyPublisher<ArticleResponseDTO, Error>
}

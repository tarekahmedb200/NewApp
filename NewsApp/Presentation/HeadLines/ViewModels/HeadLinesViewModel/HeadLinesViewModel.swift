//
//  HeadLinesViewModel.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation
import Combine


class HeadLinesViewModel: ObservableObject {
    
    @Published var articles : [Article] = []
    var cancelable = Set<AnyCancellable>()
    
    private let fetchHeadLinesUseCaseProtocol: FetchHeadLinesUseCaseProtocol
    private var coordinator : HeadLinesCoordinator
    
    init(fetchHeadLinesUseCaseProtocol: FetchHeadLinesUseCaseProtocol,coordinator : HeadLinesCoordinator) {
        self.coordinator = coordinator
        self.fetchHeadLinesUseCaseProtocol = fetchHeadLinesUseCaseProtocol
        fetchHeadLines()
    }
    
    func fetchHeadLines() {
        self.fetchHeadLinesUseCaseProtocol
            .execute()
            .receive(on: DispatchQueue.main)
            .sink {
                print($0)
            } receiveValue: { [weak self] articleDTOs in
                self?.articles = articleDTOs.toDomain().articles
            }
            .store(in: &cancelable)
    }
    
    func getArticleDetailsView(article:Article) -> ArticleDetailsView? {
        coordinator.getArticleDetailsView(article: article)
    }
    
}

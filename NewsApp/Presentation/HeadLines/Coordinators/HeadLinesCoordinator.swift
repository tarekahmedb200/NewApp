//
//  HeadLinesCoordinator.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation
import SwiftUI

class HeadLinesCoordinator: ObservableObject, Identifiable {
    
    var viewModel: HeadLinesViewModel?
    var articleDetailsViewModel: ArticleDetailsViewModel?
    private let parent: HomeCoordinator
    
    init(parent: HomeCoordinator) {
        self.parent = parent
        
        let cache: HeadLinesStorage = CoreDataHeadLinesStorage()
        let headLinesRepository : HeadLinesRepository = HeadLinesRepositoryImplmentation(headLinesFetcherService: HeadLinesFetcherServiceImplementation(), cahce: cache)
        let fetchHeadLinesUseCaseProtocol =  FetchHeadLinesUseCaseImplementation(headLinesRepository: headLinesRepository)
        self.viewModel = HeadLinesViewModel(fetchHeadLinesUseCaseProtocol: fetchHeadLinesUseCaseProtocol, coordinator: self)
        
    }
    
    func getArticleDetailsView(article:Article) -> ArticleDetailsView? {
        articleDetailsViewModel = ArticleDetailsViewModel(article: article)
        if let articleDetailsViewModel = articleDetailsViewModel {
            return ArticleDetailsView(viewModel: articleDetailsViewModel)
        }
        return nil 
    }
    
}


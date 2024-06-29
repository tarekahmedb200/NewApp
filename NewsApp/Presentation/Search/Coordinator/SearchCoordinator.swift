//
//  SearchCoordinator.swift
//  NewsApp
//
//  Created by tarek ahmed on 24/06/2024.
//

import Foundation

class SearchCoordinator: ObservableObject {
    
    var searchViewModel: SearchViewModel?
    var articleDetailsViewModel: ArticleDetailsViewModel?
    private let parent: HomeCoordinator
    
    init(parent: HomeCoordinator) {
        self.parent = parent
        
        let headLinesRepository: HeadLinesRepository = HeadLinesRepositoryImplmentation(headLinesFetcherService: HeadLinesFetcherServiceImplementation(), cahce:  CoreDataHeadLinesStorage())
        let fetchHeadLinesUseCase =  FetchHeadLinesUseCaseImplementation(headLinesRepository: headLinesRepository)
       
        let searchRepository : SearchRepository =
        SearchRepositoryImplmentation(searchService: SearchServiceImplementation(), cache: CoreDataSearchStorage())
        let searchUseCase = SearchUseCaseImplementation(searchRepository: searchRepository)
        
        self.searchViewModel = SearchViewModel(fetchHeadLinesUseCaseProtocol:fetchHeadLinesUseCase , searchUseCase: searchUseCase, coordinator: self)
        
    }
    
    func getArticleDetailsView(article:Article) -> ArticleDetailsView? {
        articleDetailsViewModel = ArticleDetailsViewModel(article: article)
        if let articleDetailsViewModel = articleDetailsViewModel {
            return ArticleDetailsView(viewModel: articleDetailsViewModel)
        }
        return nil
    }
    
}

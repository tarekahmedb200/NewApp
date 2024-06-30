//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by tarek ahmed on 26/06/2024.
//

import Foundation
import Combine

class SearchViewModel : ObservableObject {
    @Published var articles: [Article] = []
    
    @Published var searchText: String = ""
    @Published var page: Int = 1
    @Published var isSearching: Bool = false
    var isOffline: Bool {
        return !networkManager.isReachable
    }
    private var cancelable = Set<AnyCancellable>()
    private var currentSearch: String = ""
    
    private let fetchHeadLinesUseCase: FetchHeadLinesUseCase
    private let searchUseCase: SearchUseCase
    private var coordinator: SearchCoordinator
    private var networkManager : NetworkReachability
    
    init(fetchHeadLinesUseCaseProtocol: FetchHeadLinesUseCase,searchUseCase:SearchUseCase,coordinator : SearchCoordinator) {
        self.coordinator = coordinator
        self.fetchHeadLinesUseCase = fetchHeadLinesUseCaseProtocol
        self.searchUseCase = searchUseCase
        self.networkManager = NetworkReachabilityManager()
        networkManager.startMonitoring()
        observeSearchText()
    }
    
    func observeSearchText() {
        
        getPublisherWithSearchTextNotEmpty()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] articleResponseDTO in
                self?.articles += articleResponseDTO.toDomain().articles.sorted(by: {
                    $0.title < $1.title
                })
            })
            .store(in: &cancelable)
        
        getPublisherWithSearchTextEmpty()
            .receive(on: DispatchQueue.main)
            .sink {
                print($0)
            } receiveValue: { [weak self] articleResponseDTO in
                self?.articles = articleResponseDTO.toDomain().articles.sorted(by: {
                    $0.title < $1.title
                })
            }
            .store(in: &cancelable)
    }
    
    func getPublisherWithSearchTextNotEmpty() -> AnyPublisher<ArticleResponseDTO, any Error> {
        
        Publishers.CombineLatest($searchText, $page)
            .filter { text , page in
                return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            .map { [weak self] text , page  -> (String,Int) in
                if text != self?.currentSearch {
                    self?.currentSearch = text
                    self?.articles = []
                    self?.page = 1
                }
                self?.isSearching = true
                return (text,page)
            }
            .removeDuplicates { previous , next in
                previous == next
            }
            .setFailureType(to: Error.self)
            .map {  [weak self] text , page -> AnyPublisher<ArticleResponseDTO, Error>? in
                return self?.searchUseCase
                    .execute(word: text, page: page)
                    .eraseToAnyPublisher()
            }
            .compactMap{ $0 }
            .switchToLatest()
            .eraseToAnyPublisher()
        
    }
    
    func getPublisherWithSearchTextEmpty() -> AnyPublisher<ArticleResponseDTO, any Error> {
        return $searchText
            .setFailureType(to: Error.self)
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .map { [weak self] in
                self?.articles = []
                self?.page = 1
                self?.isSearching = false
                return $0
            }
            .flatMap{ [weak self] value -> AnyPublisher<ArticleResponseDTO, Error> in
                guard let self = self else { return Empty().setFailureType(to:
                                                                            Error.self).eraseToAnyPublisher() }
                
                return self.fetchHeadLinesUseCase
                    .execute()
            }
            .eraseToAnyPublisher()
    }
    
    
    func getArticleDetailsView(article:Article) -> ArticleDetailsView? {
        coordinator.getArticleDetailsView(article: article)
    }
    
    func incrementPage() {
        page += 1
    }
    
}

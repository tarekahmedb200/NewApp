//
//  SearchViewModelTestCase.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 27/06/2024.
//

import XCTest
import Combine
@testable import NewsApp

final class SearchViewModelTestCase: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private var headLinesCache: HeadLinesStorageProtocol!
    private var headLinesFetcherService :HeadLinesFetcherServiceMock!
    private var headLinesRepository : HeadLinesRepository!
    private var fetchHeadLinesUseCase : FetchHeadLinesUseCaseProtocol!
    
    private let searchedWord = "disney"
    private var searchCache: SearchStorageProtocol!
    private var searchService: SearchServiceMock!
    private var searchRepository: SearchRepositoryMock!
    private var searchUseCase : SearchUseCase!
    
    private var networkManager : NetworkReachabilityMock!
    
    private var viewModel: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        
        headLinesCache = HeadlineStorageMock()
        headLinesCache.deleteAllArticles()
        
        headLinesFetcherService = HeadLinesFetcherServiceMock()
    
        searchCache = SearchStorageMock()
        
        searchCache.deleteAllArticles(word: searchedWord)
        
        searchService = SearchServiceMock()
        
    }
    
    override func tearDown() {
        
        headLinesCache = nil
        headLinesRepository = nil
        headLinesFetcherService = nil
        fetchHeadLinesUseCase = nil
        
        
        searchCache = nil
        searchService = nil
        searchRepository = nil
        searchUseCase = nil
        
        networkManager = nil
        viewModel = nil
    }
    
    func testSearchViewModel_whenNoSearch_thenShowHeadLines() throws {
        
        var expectedArticles = [Article]()
         
        let expectation = self.expectation(description: "expectation")
        
        // mock offline status so to get from cache
        networkManager = NetworkReachabilityMock(isReachable: true)
        
        headLinesRepository = HeadLinesRepositoryMock(headLinesFetcherService: headLinesFetcherService, cahce: headLinesCache, networkReachabilityManager: networkManager)
        
        fetchHeadLinesUseCase =  DefaultFetchHeadLinesUseCaseImplementation(headLinesRepository: headLinesRepository)
        
        searchRepository = SearchRepositoryMock(searchService: searchService, cache: searchCache, networkReachabilityManager: networkManager)
        searchUseCase = DefaultSearchUseCaseImplementation(searchRepository: searchRepository)
        
        viewModel = SearchViewModel(fetchHeadLinesUseCaseProtocol: fetchHeadLinesUseCase, searchUseCase: searchUseCase, coordinator: SearchCoordinator(parent: HomeCoordinator()))
        
         viewModel.getPublisherWithSearchTextEmpty()
            .sink {
                print($0)
            } receiveValue: { articleResponseDTO in
                expectation.fulfill()
                expectedArticles = articleResponseDTO.toDomain().articles
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
        
        //after fetching data
        XCTAssertTrue(expectedArticles.count > 0)
    }
    
    func testSearchViewModel_whenOfflineAndNoSearch_thenShowHeadLineCachedData() {
        
        var expectedArticles = [Article]()
        
        let expectation = self.expectation(description: "expectation")
        
        // mock offline status so to get from cache
        networkManager = NetworkReachabilityMock(isReachable: false)
        
        headLinesRepository = HeadLinesRepositoryMock(headLinesFetcherService: headLinesFetcherService, cahce: headLinesCache, networkReachabilityManager: networkManager)
        fetchHeadLinesUseCase =  DefaultFetchHeadLinesUseCaseImplementation(headLinesRepository: headLinesRepository)
        
        searchRepository = SearchRepositoryMock(searchService: searchService, cache: searchCache, networkReachabilityManager: networkManager)
        searchUseCase = DefaultSearchUseCaseImplementation(searchRepository: searchRepository)
        
        viewModel = SearchViewModel(fetchHeadLinesUseCaseProtocol: fetchHeadLinesUseCase, searchUseCase: searchUseCase, coordinator: SearchCoordinator(parent: HomeCoordinator()))
        
        //saving mock data
        headLinesCache.save(articles: [PreviewArticleDTO.previewArticles.first!])
        
        viewModel.getPublisherWithSearchTextEmpty()
           .sink {
               print($0)
           } receiveValue: { articleResponseDTO in
               expectation.fulfill()
               expectedArticles = articleResponseDTO.toDomain().articles
           }
           .store(in: &cancellables)
       
       waitForExpectations(timeout: 1)
       
       //after fetching data
       XCTAssertTrue(expectedArticles.count == 1)
    }
    
    func testSearchViewModel_whenSearchAndIncreasePage_thenShowNextSearchedData() {
        
        var expectedArticles = [Article]()
        
        // mock offline status so to get from cache
        networkManager = NetworkReachabilityMock(isReachable: true)
        
        headLinesRepository = HeadLinesRepositoryMock(headLinesFetcherService: headLinesFetcherService, cahce: headLinesCache, networkReachabilityManager: networkManager)
        fetchHeadLinesUseCase = DefaultFetchHeadLinesUseCaseImplementation(headLinesRepository: headLinesRepository)
        
        searchRepository = SearchRepositoryMock(searchService: searchService, cache: searchCache, networkReachabilityManager: networkManager)
        searchUseCase = DefaultSearchUseCaseImplementation(searchRepository: searchRepository)
        
        viewModel = SearchViewModel(fetchHeadLinesUseCaseProtocol: fetchHeadLinesUseCase, searchUseCase: searchUseCase, coordinator: SearchCoordinator(parent: HomeCoordinator()))
        
        viewModel.getPublisherWithSearchTextNotEmpty()
           .sink {
               print($0)
           } receiveValue: { articleResponseDTO in
               expectedArticles = articleResponseDTO.toDomain().articles
           }
           .store(in: &cancellables)
       
        viewModel.searchText = "disney"
        
        viewModel.incrementPage()
        
       //after fetching data
       XCTAssertTrue(expectedArticles.count == 20)
    }

    
    
    
    

}

//
//  SearchUseCaseTest.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 26/06/2024.
//

import XCTest
import Combine
@testable import NewsApp

final class SearchUseCaseTest: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private let searchedWord = "disney"
    private var searchCache: SearchStorage!
    private var searchService: SearchServiceMock!
    private var searchRepository: SearchRepositoryMock!
    private var networkManager: NetworkReachabilityMock!
    
    
    override func setUp() {
        super.setUp()
        cancellables = []
        
        searchCache =  SearchStorageMock()
        
        searchCache.deleteAllArticles(word: searchedWord)
        
        searchService = SearchServiceMock()
    }
    
    override func tearDown() {
        
        searchService = nil
        searchCache = nil
        searchRepository = nil
        networkManager = nil
    }
    
    func testFetchHeadLinesUseCaseTest_whenSuccessfullyFetchesSearchedNews_thenNewsIsSavedInDB() throws {
        
        let expectation = self.expectation(description: "expectation")

        networkManager = NetworkReachabilityMock(isReachable: true)
        
        searchRepository = SearchRepositoryMock(searchService: searchService, cache: searchCache, networkReachabilityManager: networkManager)
        
        let searchUseCase =
        SearchUseCaseImplementation(searchRepository: searchRepository)
        
        //before fetching data
        XCTAssertTrue(try searchCache.fetchSearchedArticles(word: searchedWord).count == 0)
        
        searchUseCase
            .execute(word: searchedWord, page: 1)
            .sink { _ in
                print("complete..")
                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
        
        //after fetching data
        XCTAssertTrue(try searchCache.fetchSearchedArticles(word: searchedWord).count > 0)
    }

}

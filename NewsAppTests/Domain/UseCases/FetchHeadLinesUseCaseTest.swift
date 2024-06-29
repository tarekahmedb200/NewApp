//
//  FetchHeadLinesUseCaseTest.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 21/06/2024.
//

import XCTest
import Combine
@testable import NewsApp

final class FetchHeadLinesUseCaseTest: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private var cache: HeadLinesStorage!
    private var headLinesFetcherService :HeadLinesFetcherServiceMock!
    private var networkManager : NetworkReachabilityMock!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        cache = HeadlineStorageMock()
        
        cache.deleteAllArticles()
        
        headLinesFetcherService = HeadLinesFetcherServiceMock()
    }
    
    override func tearDown() {
       
        cache = nil
        headLinesFetcherService = nil
        networkManager = nil
    }
    
    func testFetchHeadLinesUseCaseTest_whenSuccessfullyFetchesNews_thenNewsIsSavedInDB() throws {
        
        let expectation = self.expectation(description: "expectation")

        networkManager = NetworkReachabilityMock(isReachable: true)
        
        let headLinesRepository : HeadLinesRepository = HeadLinesRepositoryMock(headLinesFetcherService: headLinesFetcherService, cahce: cache, networkReachabilityManager: networkManager)
        
        let fetchHeadLinesUseCase =  FetchHeadLinesUseCaseImplementation(headLinesRepository: headLinesRepository)
        
        //before fetching data
        XCTAssertTrue(try cache.fetchArticles().count == 0)
        
        fetchHeadLinesUseCase
            .execute()
            .sink { _ in
                print("complete..")
                expectation.fulfill()
            } receiveValue: { articleResponseDTO in
                _ = articleResponseDTO.toDomain().articles
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
        
        //after fetching data
        XCTAssertTrue(try cache.fetchArticles().count > 0)
    }

}

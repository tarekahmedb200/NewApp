//
//  HeadLineItemViewModelTestCase.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 25/06/2024.
//

import XCTest
import Combine
@testable import NewsApp

final class HeadLineItemViewModelTestCase: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private var cache: CoreDataHeadLinesStorage!
    private var headLinesFetcherService :HeadLinesFetcherServiceMock!
    private var headLinesRepository : HeadLinesRepository!
    private var fetchHeadLinesUseCase : FetchHeadLinesUseCase!
    private var networkManager : NetworkReachabilityMock!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        
        cache = CoreDataHeadLinesStorage(context: CoreDataStack.preview.persistentContainer.viewContext)
        cache.deleteAllArticles()
        
        headLinesFetcherService = HeadLinesFetcherServiceMock()
    }
    
    override func tearDown() {
        
        cache = nil
        headLinesFetcherService = nil
        headLinesRepository = nil
        fetchHeadLinesUseCase = nil
        
        networkManager = nil
    }
    
    func testHeadLineItemViewModel_whenOffline_thenShowCachedData() throws {
        
        var expectedArticles = [Article]()
        
        let expectation = self.expectation(description: "expectation")
        
        // mock offline status so to get from cache
        networkManager = NetworkReachabilityMock(isReachable: false)
        
        headLinesRepository = HeadLinesRepositoryMock(headLinesFetcherService: headLinesFetcherService, cahce: cache, networkReachabilityManager: networkManager)
        fetchHeadLinesUseCase =  FetchHeadLinesUseCaseImplementation(headLinesRepository: headLinesRepository)
        
        //saving mock data
        cache.save(articles: [PreviewArticleDTO.previewArticles.first!])
        
        fetchHeadLinesUseCase
            .execute()
            .sink { _ in
                print("complete..")
                expectation.fulfill()
            } receiveValue: { articleResponseDTO in
                expectedArticles = articleResponseDTO.toDomain().articles
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
        
        //after fetching data
        XCTAssertTrue(expectedArticles.count == 1)
    }

    
    
    
    
    
}

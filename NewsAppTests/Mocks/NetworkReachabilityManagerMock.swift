//
//  NetworkReachabilityMock.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
@testable import NewsApp

class NetworkReachabilityMock: NetworkReachability {
    var isReachable: Bool = false
    
    init(isReachable: Bool) {
        self.isReachable = isReachable
    }
    
    func startMonitoring() { }
}

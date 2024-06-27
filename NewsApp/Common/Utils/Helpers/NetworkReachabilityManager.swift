//
//  NetworkReachabilityManager.swift
//  NewsApp
//
//  Created by tarek ahmed on 24/06/2024.
//

import Foundation
import Network

protocol NetworkReachability {
  var isReachable: Bool { get }
  func startMonitoring()
}


class NetworkReachabilityManager: ObservableObject , NetworkReachability {
    
    @Published var isReachable: Bool = false
    
    private let monitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied
        }
    }
    
    func startMonitoring() {
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
}

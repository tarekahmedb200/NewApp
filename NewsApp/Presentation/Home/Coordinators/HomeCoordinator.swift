//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation
import SwiftUI

enum HomeTab {
    case headLines
    case search
}

class HomeCoordinator: ObservableObject {
    
    @Published var tab = HomeTab.headLines
    @Published var headLinesCoordinator: HeadLinesCoordinator?
    @Published var searchCoordinator: SearchCoordinator?
    
    init() {
        self.headLinesCoordinator = HeadLinesCoordinator(parent: self)
        self.searchCoordinator = SearchCoordinator(parent: self)
    }
}

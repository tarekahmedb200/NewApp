//
//  HomeCoordinatorView.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation
import SwiftUI

struct HomeCoordinatorView: View {

    // MARK: Stored Properties

    @ObservedObject var coordinator: HomeCoordinator

    // MARK: Views

    var body: some View {
        TabView(selection: $coordinator.tab) {
            
            if let headLinesCoordinator = coordinator.headLinesCoordinator {
                HeadLinesCoordinatorView(coordinator: headLinesCoordinator)
                .tabItem { Label("headLines", systemImage: "house") }
                .tag(HomeTab.headLines)
            }
            
            if let searchCoordinator = coordinator.searchCoordinator {
                SearchCoordinatorView(coordinator: searchCoordinator)
                .tabItem { Label("search", systemImage: "magnifyingglass") }
                .tag(HomeTab.search)
            }
            
        }
    }

}

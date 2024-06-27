//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by tarek ahmed on 21/06/2024.
//

import SwiftUI

@main
struct NewsApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeCoordinatorView(coordinator: HomeCoordinator())
        }
    }
}

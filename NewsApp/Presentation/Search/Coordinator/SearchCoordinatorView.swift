//
//  SearchCoordinatorView.swift
//  NewsApp
//
//  Created by tarek ahmed on 24/06/2024.
//

import Foundation
import SwiftUI


struct SearchCoordinatorView: View {
    
    @ObservedObject var coordinator: SearchCoordinator
    
    var body: some View {
        
        NavigationView {
            if let viewModel = coordinator.searchViewModel {
                SearchView(viewModel: viewModel)
            }
        }
    }
    
}

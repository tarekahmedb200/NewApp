//
//  HeadLinesCoordinatorView.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation
import SwiftUI

struct HeadLinesCoordinatorView: View {

    // MARK: Stored Properties

    @ObservedObject var coordinator: HeadLinesCoordinator

    // MARK: Views

    var body: some View {
        
        NavigationView {
            if let viewModel = coordinator.viewModel {
                HeadLinesView(viewModel: viewModel)
            }
        }
        
    }

}

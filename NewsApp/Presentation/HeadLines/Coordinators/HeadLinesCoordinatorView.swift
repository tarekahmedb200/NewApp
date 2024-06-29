//
//  HeadLinesCoordinatorView.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation
import SwiftUI

struct HeadLinesCoordinatorView: View {

    @ObservedObject var coordinator: HeadLinesCoordinator

    var body: some View {
        
        NavigationStack {
            if let viewModel = coordinator.viewModel {
                HeadLinesView(viewModel: viewModel)
            }
        }
    }

}

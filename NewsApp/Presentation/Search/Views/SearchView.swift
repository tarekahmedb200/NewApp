//
//  SearchView.swift
//  NewsApp
//
//  Created by tarek ahmed on 26/06/2024.
//

import SwiftUI

struct SearchView: View {
    
    @State private var scrollViewProxy: CGFloat = .zero
    
    @ObservedObject var viewModel: SearchViewModel
    
    var columns: [GridItem] =
    Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200)), count: 1)
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                LazyVGrid(columns: columns,alignment: .center) {
                    ForEach(viewModel.articles) { article in
                        NavigationLink {
                            if let articleDetailsView = viewModel.getArticleDetailsView(article: article) {
                                articleDetailsView
                            }
                        } label: {
                            SearchItemRowView(viewModel: SearchItemViewModel(article: article))
                        }
                    }
                    
                    if viewModel.isSearching {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .onAppear {
                                viewModel.incrementPage()
                            }
                    }
                }
                .searchable(text: $viewModel.searchText)
            }
        }
    }
}

//#Preview {
//    SearchView(viewModel: SearchViewModel)
//}


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
    @State var isAnimation = false
    
    var columns: [GridItem] =
    Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200)), count: 1)
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: columns,alignment: .center) {
                    ForEach(viewModel.articles) { article in
                        NavigationLink {
                            if let articleDetailsView = viewModel.getArticleDetailsView(article: article) {
                                articleDetailsView
                            }
                        } label: {
                            SearchItemRowView(viewModel: SearchItemViewModel(article: article))
                                .opacity(isAnimation ? 1 : 0)
                        }
                    }
                    
                    if viewModel.isSearching && !viewModel.isOffline {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .onAppear {
                                viewModel.incrementPage()
                            }
                    }
                }
                .searchable(text: $viewModel.searchText)
            }
            .onAppear {
                
                withAnimation(.bouncy) {
                    isAnimation = true
                }
                
            }
            .onChange(of: viewModel.articles) {
                
                withAnimation(.bouncy) {
                    isAnimation = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.bouncy) {
                        isAnimation = true
                    }
                }
                
            }
        
        
    }
}



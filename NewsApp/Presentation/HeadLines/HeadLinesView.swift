//
//  HeadLinesView.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import SwiftUI

struct HeadLinesView: View {
    
    
    @StateObject var viewModel : HeadLinesViewModel
    
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.articles) { article in
                    NavigationLink {
                        if let articleDetailsView = viewModel.getArticleDetailsView(article: article) {
                            articleDetailsView
                        }
                    } label: {
                        HeadLineItemView(viewModel: HeadLineItemViewModel(article: article))
                            .shadow(radius: 10)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned) // Set the behavior
        .safeAreaPadding(.horizontal, 10)
        
    }
}

//#Preview {
//    HeadLinesView(viewModel: HeadLinesViewModel(fetchHeadLinesUseCaseProtocol: DefaultFetchHeadLinesUseCaseImplementation(headLinesRepository: DefaultHeadLinesRepositoryImplmentation(ApiManager: APIManager()))))
//}

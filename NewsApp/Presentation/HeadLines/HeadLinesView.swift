//
//  HeadLinesView.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import SwiftUI

struct HeadLinesView: View {
    
    @StateObject var viewModel: HeadLinesViewModel
    @State var currentIndex: Int = 0
    @State var isAnimation = false
    @State var yTransition : CGFloat = -50.0
    
    var body: some View {
        
        ZStack {
            
            if viewModel.articles.count == 0 {
                LoadingView()
            }else {
                ForEach(0..<viewModel.articles.count,id:\.self) { index in
                    
                    NavigationLink {
                        if let articleDetailsView = viewModel.getArticleDetailsView(article: viewModel.articles[currentIndex]) {
                            articleDetailsView
                        }
                    } label: {
                        HeadLineItemView(viewModel: HeadLineItemViewModel(article: viewModel.articles[index]))
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 300, y :yTransition)
                            .opacity(isAnimation ? 1 : 0)
                    }
                }
            }
        }
        .onChange(of: viewModel.articles) {
            withAnimation(.bouncy) {
                isAnimation = viewModel.articles.count > 0
                yTransition *= viewModel.articles.count > 0 ? 0 : -50
            }
        }
        .navigationTitle("Headlines")
        .navigationBarTitleDisplayMode(.large)
        .highPriorityGesture(DragGesture(minimumDistance: 25)
            .onEnded({ value in
                let threshold : CGFloat = 50
                
                if value.translation.width > threshold {
                    
                    withAnimation {
                        currentIndex = max(0, currentIndex - 1)
                    }
                    
                } else if value.translation.width < -threshold {
                    withAnimation {
                        currentIndex = min(viewModel.articles.count - 1 , currentIndex + 1)
                    }
                }
                
            })
        )
    }
    
}


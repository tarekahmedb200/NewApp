//
//  ArticleDetailsView.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct ArticleDetailsView: View {
    @Namespace private var animation
    
    var viewModel: ArticleDetailsViewModel
    
    var body: some View {
        
        VStack(spacing:0) {
            
            ScrollView(.vertical,showsIndicators: false) {
                
                titleView
                
                headerView
                
                contentView
            }
            .frame(width: UIScreen.main.bounds.width)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let shareURL = viewModel.url {
                        ShareLink("Share My Link", item: shareURL)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var headerView : some View {
        Group {
            if let posterImagePathUrl = viewModel.posterImagePathUrl {
                KFImage.url(posterImagePathUrl)
                    .placeholder{
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        
        VStack(alignment:.leading,spacing: 5) {
            Text(viewModel.title )
                .font(.system(size: 25,weight: .bold))
                .foregroundStyle(.black)
            
            Text(viewModel.hoursAgo ?? "")
                .font(.title3)
            
            HStack {
                Text(viewModel.author)
                Text(viewModel.source)
            }
            .font(.title2)
        }
        .padding()
    }
    
    @ViewBuilder
    var contentView: some View {
        Text(viewModel.content)
            .lineLimit(nil)
            .foregroundColor(.black)
            .font(.system(size: 25,design: .serif))
            .padding()
    }
}

//#Preview {
//    ReceipeDetailsView(viewModel: ReceipeDetailsViewModel(
//        objectReceipe: Receipe.mockSearchedReceipes.first!,
//        receipeDetailsFetcher: ReceipeDetailsFetcherMock(),
//        receipeDetailsStore: ReceipeDetailsStore(context:
//                                                    PersistenceController.preview.container.viewContext)
//        ,imageRemoteService: ImageRemoteService(requestManager: DataAPIManger()), imageLocalService: ImageLocalService()))
//}

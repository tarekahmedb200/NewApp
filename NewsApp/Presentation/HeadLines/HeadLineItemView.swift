//
//  HeadLineItemView.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import SwiftUI
import Kingfisher

struct HeadLineItemView: View {
    
    var viewModel: HeadLineItemViewModel
    
    var body: some View {
        
            ZStack {
                
                AngularGradient(colors: [.black.opacity(0.6),.white.opacity(0.6)], center: .topLeading)
                
                VStack(alignment:.leading,spacing: 15) {
                    
                    Text(viewModel.title)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    
                    Text(viewModel.source)
                        .font(.title3)
                    
                    Text(viewModel.publishedDate ?? "")
                        .font(.title3)
                    
                }
                .padding()
                .foregroundStyle(.white)
            }
            .background{
                if let posterImagePathUrl = viewModel.posterImagePathUrl {
                    KFImage.url(posterImagePathUrl)
                        .placeholder{
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width:300 ,height:500)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
}

#Preview {
    HeadLineItemView(viewModel: HeadLineItemViewModel(article: PreviewArticleDTO.previewArticles.first!.toDomain()))
        .previewLayout(.sizeThatFits)
}

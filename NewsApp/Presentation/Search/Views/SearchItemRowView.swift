//
//  SearchItemRowView.swift
//  NewsApp
//
//  Created by tarek ahmed on 26/06/2024.
//

import SwiftUI

import Kingfisher


struct SearchItemRowView: View {
    
    var viewModel: SearchItemViewModel
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            VStack(alignment:.leading,spacing: 5) {
                Text(viewModel.title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    
                Text(viewModel.publishedDate ?? "")
                    .font(.subheadline)
                
                Text(viewModel.source)
                    .font(.subheadline)
            }
            .foregroundStyle(.black)
            
            Spacer()
            
            if let thumb = viewModel.posterImagePathUrl {
                KFImage.url(thumb)
                    .placeholder{
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100,height:150)
                    .clipShape(
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    )
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        
        
    }
}


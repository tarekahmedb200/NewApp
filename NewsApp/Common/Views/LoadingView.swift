//
//  LoadingView.swift
//  NewsApp
//
//  Created by tarek ahmed on 30/06/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView {
                Text("Loading....")
                    .font(.title)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    LoadingView()
}

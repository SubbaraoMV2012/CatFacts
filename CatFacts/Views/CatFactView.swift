//
//  CatfactView.swift
//  CatFacts
//
//  Created by SubbaRao MV on 24/04/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CatFactView: View {
    @StateObject var viewModel = CatFactViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let imageUrl = viewModel.catImageUrl, let url = URL(string: imageUrl) {
                WebImage(url: url)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(16)
                    .shadow(radius: 8)
                    .transition(.scale.combined(with: .opacity))
            }
            Text(viewModel.catFact ?? "")
                .padding()
                .multilineTextAlignment(.center)
                .font(.title)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .padding()
        .onTapGesture {
            Task {
                await viewModel.getCatData()
            }
        }
    }
}

#Preview {
    CatFactView()
}

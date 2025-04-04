//
//  CompanyDetailView.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct CompanyDetailView: View {
    let company: Company
    @State var viewModel: Company_ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    // logo placeholder
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 60, height: 60)
                        
                        Text(company.symbol.prefix(2))
                            .font(.title)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(company.name)
                            .font(.title)
                            .bold()
                        Text(company.symbol)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleFavorite(for: company)
                    }) {
                        Image(systemName: viewModel.isFavorite(company: company) ? "star.fill" : "star")
                            .font(.title)
                            .foregroundColor(.yellow)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Company details
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Market Cap")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(company.marketCap.longFmt)
                            .font(.body)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(company.symbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}

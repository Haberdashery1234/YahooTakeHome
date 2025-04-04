//
//  CompanyListView.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct CompanyListView: View {
    @State var viewModel: Company_ViewModel
    @State var showOnlyFavorites: Bool
    
    var body: some View {
        List(showOnlyFavorites ? viewModel.favoriteCompanies : viewModel.sortedCompanies) { company in
            NavigationLink(destination: CompanyDetailView(company: company, viewModel: viewModel)) {
                HStack {
                    Image(systemName: viewModel.isFavorite(company: company) ? "star.fill" : "star").foregroundColor(.yellow)
                    
                    // logo placeholder
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 30, height: 30)
                        
                        Text(company.symbol.prefix(2))
                            .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(company.name)
                            .font(.headline)
                        Text(company.symbol)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text(company.marketCap.fmt)
                }
            }
            .swipeActions(edge: .leading) {
                Button {
                    viewModel.toggleFavorite(for: company)
                } label: {
                    Label("Favorite", systemImage: "star")
                }
                .tint(.yellow)
            }
        }
        .padding(.top)
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            await viewModel.loadCompanies()
        }
        .onAppear {
            Task {
                await viewModel.loadCompanies()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search companies")
    }
}

//
//  CompareView.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct CompareView: View {
//    @State private var viewModel: ViewModel
//    @State private var selectedCompanies = Set<String>()
    
    var body: some View {
        Text("I'm in compare mode")
//        VStack {
//            // Comparison area
//            if selectedCompanies.count >= 2 {
//                ScrollView {
//                    ComparisonChart(companies: viewModel.companies.filter { selectedCompanies.contains($0.symbol) })
//                        .frame(height: 300)
//                        .padding()
//                    
//                    ComparisonTable(companies: viewModel.companies.filter { selectedCompanies.contains($0.symbol) })
//                        .padding()
//                }
//            } else {
//                ContentUnavailableView {
//                    Label("Select Companies", systemImage: "chart.bar.doc.horizontal")
//                } description: {
//                    Text("Select 2 or more companies to compare")
//                } actions: {
//                    Text("Tap companies in the list above")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                }
//            }
//        }
    }
}

struct ComparisonChart: View {
    let companies: [Company]
    
    var body: some View {
        VStack {
            Text("Market Cap Comparison")
                .font(.headline)
                .padding(.bottom)
            
            GeometryReader { proxy in
                HStack(alignment: .bottom, spacing: 20) {
                    ForEach(companies) { company in
                        VStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue.gradient)
                                .frame(width: max(proxy.frame(in: .global).width / CGFloat(companies.count) - 20, 10), height: normalizedHeight(for: company))
                            
                            Text(company.symbol)
                                .font(.caption)
                                .fixedSize()
                        }
                    }
                }
                .frame(width: proxy.frame(in: .global).width - 50, height: 250, alignment: .center)
                .padding()
            }
        }
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func normalizedHeight(for company: Company) -> CGFloat {
        let maxMarketCap = companies.map { $0.marketCap.raw }.max() ?? 1
        return CGFloat(company.marketCap.raw / maxMarketCap) * 220
    }
}

struct ComparisonTable: View {
    let companies: [Company]
    
    var body: some View {
        VStack {
            Text("Detailed Comparison")
                .font(.headline)
                .padding(.bottom)
            
            // Table header
            Grid(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 8) {
                GridRow {
                    Text("Metric")
                        .font(.subheadline.bold())
                    
                    ForEach(companies) { company in
                        Text(company.symbol)
                            .font(.subheadline.bold())
                    }
                }
                .padding(.vertical, 5)
                .gridCellColumns(companies.count + 1)
                .background(Color.gray.opacity(0.2))
                
                Divider()
                    .gridCellColumns(companies.count + 1)
                
                // Market Cap row
                GridRow {
                    Text("Market Cap")
                        .font(.subheadline)
                    
                    ForEach(companies) { company in
                        Text(company.marketCap.fmt)
                            .font(.callout)
                    }
                }
                .padding(.vertical, 5)
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

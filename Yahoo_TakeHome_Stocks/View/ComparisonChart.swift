//
//  ComparisonChart.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/8/25.
//

import SwiftUI
import Charts

struct ComparisonChart: View {
    let companies: [Company]
    
    var body: some View {
        VStack {
            Text("Market Cap Comparison")
                .font(.headline)
                .padding(.bottom)
            
            Chart(companies) { company in
                BarMark(x: .value("Company", company.symbol),
                        y: .value("Markey Cap", company.marketCap.raw),
                        width: 40)
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

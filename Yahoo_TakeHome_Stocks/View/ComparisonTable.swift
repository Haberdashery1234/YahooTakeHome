//
//  ComparisonTable.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/8/25.
//

import SwiftUI

struct ComparisonTable: View {
    let companies: [Company]
    
    var body: some View {
        VStack {
            Text("Detailed Comparison")
                .font(.headline)
                .padding(.bottom)
            
            Table(companies) {
                TableColumn("Symbol", value: \.symbol)
                TableColumn("Market Cap", value: \.marketCap.longFmt)
            }
        }
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


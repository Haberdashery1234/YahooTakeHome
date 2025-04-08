//
//  CompanyRow.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct CompanyRow: View {
    let company: Company
    let isFavorite: Bool
    
    var body: some View {
        HStack {
            // Placeholder for company logo
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Text(company.symbol.prefix(1))
                    .font(.headline)
            }
            
            VStack(alignment: .leading) {
                Text(company.name)
                    .font(.headline)
                Text(company.symbol)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(company.marketCap.fmt)
                    .font(.subheadline)
                
                if isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

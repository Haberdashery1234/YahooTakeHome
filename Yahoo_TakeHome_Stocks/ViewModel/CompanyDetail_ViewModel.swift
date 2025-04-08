//
//  CompanyDetail_ViewModel.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/7/25.
//

import Foundation

extension CompanyDetailView {
    struct ViewModel {
        let company: Company
        var favorites = Favorites()
        
        func toggleFavorite() {
            if favorites.contains(company) {
                favorites.remove(company)
            } else {
                favorites.add(company)
            }
            
            // Persist changes
            favorites.save()
        }
        
        func isFavorite() -> Bool {
            favorites.contains(company)
        }
    }
}

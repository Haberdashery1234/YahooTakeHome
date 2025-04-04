//
//  PreferencesManager.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import Foundation

class PreferencesManager {
    private let favoritesKey = "FavoriteCompanies"
    private let sortOrderKey = "SortOrder"
    
    enum SortOrder: String, CaseIterable, Identifiable {
        case name = "Company Name"
        case marketCap = "Market Cap"
        
        var id: String { self.rawValue }
    }
    
    // Save favorite companies
    func saveFavorites(_ symbols: Set<String>) {
        UserDefaults.standard.set(Array(symbols), forKey: favoritesKey)
    }
    
    // Load favorite companies
    func loadFavorites() -> Set<String> {
        let symbols = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        return Set(symbols)
    }
    
    // Save sort order
    func saveSortOrder(_ order: SortOrder) {
        UserDefaults.standard.set(order.rawValue, forKey: sortOrderKey)
    }
    
    // Load sort order
    func loadSortOrder() -> SortOrder {
        let orderString = UserDefaults.standard.string(forKey: sortOrderKey) ?? SortOrder.name.rawValue
        return SortOrder(rawValue: orderString) ?? .name
    }
}

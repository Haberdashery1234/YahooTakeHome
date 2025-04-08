//
//  AppSettings.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/7/25.
//

import Foundation

@Observable
class AppSettings {
    enum SortType: String, CaseIterable, Identifiable {
        case name
        case marketCap
        
        var id: String { self.rawValue }
        
        var description: String {
            switch self {
            case .name:
                return "Name"
            case .marketCap:
                return "Market Cap"
            }
        }
    }
    
    private let sortOrderKey = "SortOrder"
    
    var sortBy: SortType = .name
    var showOnlyFavorites: Bool = false
    var refreshInterval: TimeInterval = 30
    var lastRefreshDate: Date?
    
    // Save sort order
    func saveSortOrder(_ order: SortType) {
        UserDefaults.standard.set(order.rawValue, forKey: sortOrderKey)
    }
    
    // Load sort order
    func loadSortOrder() -> SortType {
        let orderString = UserDefaults.standard.string(forKey: sortOrderKey) ?? SortType.name.rawValue
        return SortType(rawValue: orderString) ?? .name
    }
}

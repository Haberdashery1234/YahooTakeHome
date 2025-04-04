//
//  Stock_ViewModel.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import Foundation
import Combine

@Observable
class Company_ViewModel {
    var companies: [Company] = []
    var favoriteSymbols: Set<String> = []
    var sortOrder: PreferencesManager.SortOrder = .name {
        didSet {
            
        }
    }
    var isLoading: Bool = false
    var errorMessage: String?
    var searchText: String = ""
    
    private var timer: AnyCancellable?

    private let service = CompanyService()
    private let preferenceManager = PreferencesManager()
    
    init() {
        // Load user preferences
        favoriteSymbols = preferenceManager.loadFavorites()
        sortOrder = preferenceManager.loadSortOrder()
        
        // Initial data load
        Task {
            await loadCompanies()
        }
    }
    
    func startAutoRefresh() {
        timer = Timer
            .publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fireTimer()
            }
    }
    
    func stopAutoRefresh() {
        timer?.cancel()
    }
    
    func fireTimer() {
        print("Firing timer")
        Task {
            await loadCompanies()
        }
    }
    
    @MainActor
    func loadCompanies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            companies = try await service.fetchCompanyData()
            isLoading = false
        } catch {
            errorMessage = "Failed to load companies: \(error.localizedDescription)"
            isLoading = false
        }
    }
    
    var sortedCompanies: [Company] {
        let filtered = searchText.isEmpty ?
        companies :
        companies.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.symbol.localizedCaseInsensitiveContains(searchText) }
        
        switch sortOrder {
        case .name:
            return filtered.sorted { $0.name < $1.name }
        case .marketCap:
            return filtered.sorted { $0.marketCap > $1.marketCap }
        }
    }
    
    var favoriteCompanies: [Company] {
        sortedCompanies.filter { favoriteSymbols.contains($0.symbol) }
    }
    
    func toggleFavorite(for company: Company) {
        if favoriteSymbols.contains(company.symbol) {
            favoriteSymbols.remove(company.symbol)
        } else {
            favoriteSymbols.insert(company.symbol)
        }
        
        // Persist changes
        preferenceManager.saveFavorites(favoriteSymbols)
    }
    
    func updateSortOrder(_ order: PreferencesManager.SortOrder) {
        sortOrder = order
        preferenceManager.saveSortOrder(order)
    }
    
    func isFavorite(company: Company) -> Bool {
        favoriteSymbols.contains(company.symbol)
    }
}

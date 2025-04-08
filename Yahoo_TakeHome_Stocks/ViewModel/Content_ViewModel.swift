//
//  Stock_ViewModel.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import Foundation
import Combine

extension ContentView {
    @Observable
    class ViewModel {
        var companies: [Company] = []
        var favorites = Favorites()
        
        private let settings: AppSettings
        var isLoading: Bool = false
        var errorMessage: String?
        var searchText: String = ""
        
        private var timer: AnyCancellable?
        
        private let service = NetworkService()
        
        init(settings: AppSettings) {
            self.settings = settings
            
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
            
            switch settings.sortBy {
            case .name:
                return filtered.sorted { $0.name < $1.name }
            case .marketCap:
                return filtered.sorted { $0.marketCap > $1.marketCap }
            }
        }
        
        var favoriteCompanies: [Company] {
            let allFavs = favorites.allFavorites()
            return sortedCompanies.filter { allFavs.contains($0.symbol) }
        }
        
        func toggleFavorite(for company: Company) {
            if favorites.contains(company) {
                favorites.remove(company)
            } else {
                favorites.add(company)
            }
            
            // Persist changes
            favorites.save()
        }
        
        func isFavorite(company: Company) -> Bool {
            favorites.contains(company)
        }
    }
}

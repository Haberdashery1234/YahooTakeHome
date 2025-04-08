//
//  ContentView.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var selectedCompany: Company?
    @State var selectedCompanies = Set<Company>()
    
    @State private var appSettings = AppSettings()
    @State private var viewModel: ViewModel
    
    @State private var isShowingSettings = false
    @State private var isInCompareMode = false
    
    init() {
        let settings = AppSettings()
        self._appSettings = State(initialValue: settings)
        self._viewModel = State(initialValue: ViewModel(settings: settings))
    }
    
    var body: some View {
        NavigationSplitView {
            Group {
                if isInCompareMode {
                    List(appSettings.showOnlyFavorites ? viewModel.favoriteCompanies : viewModel.sortedCompanies, id: \.symbol, selection: $selectedCompanies) { company in
                        CompanyRow(company: company, isFavorite: viewModel.favorites.contains(company)).tag(company.symbol)
                    }
                    .id(isInCompareMode ? "compare" : "list")
                    .environment(\.editMode, .constant(.active))
                } else {
                    List(appSettings.showOnlyFavorites ? viewModel.favoriteCompanies : viewModel.sortedCompanies, selection: $selectedCompany) { company in
                        NavigationLink(destination: CompanyDetailView(company: company)) {
                            CompanyRow(company: company, isFavorite: viewModel.favorites.contains(company))
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
                    .id(isInCompareMode ? "compare" : "list")
                }
            }
            .environment(\.editMode, isInCompareMode ? .constant(.active) : .constant(.inactive))
            .padding(.top)
            .navigationTitle(appSettings.showOnlyFavorites ? "Favorites" : "All Companies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isInCompareMode.toggle() }) {
                        Image(systemName: isInCompareMode ? "chart.bar.fill" : "chart.bar")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingSettings = true }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView(settings: $appSettings)
            }
            .onChange(of: isInCompareMode) {
                print(selectedCompanies)
                selectedCompanies.removeAll()
            }
            .onChange(of: selectedCompanies) { oldValue, newValue in
                print(newValue)
                if !isInCompareMode && newValue.count > 1 {
                    let latestSelection = newValue.subtracting(oldValue).first
                    selectedCompanies = latestSelection.map { Set([$0]) } ?? Set()
                }
            }
        } detail: {
            if isInCompareMode {
                if selectedCompanies.count > 0 {
                    CompareView()
                } else {
                    ContentUnavailableView {
                        Label("No companies selected", systemImage: "questionmark")
                    } description: {
                        Text("You have to select multiple companies from the list on the left")
                    } actions: {
                        // No actions
                    }
                }
            } else {
                if let selectedCompany {
                    CompanyDetailView(company: selectedCompany)
                } else {
                    ContentUnavailableView {
                        Label("No company selected", systemImage: "questionmark")
                    } description: {
                        Text("You have to select a company from the list on the left")
                    } actions: {
                        // No actions
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

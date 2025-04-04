//
//  ContentView.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = Company_ViewModel()
    @State private var isShowingSettings = false
    
    var body: some View {
        TabView {
            NavigationView {
                CompanyListView(viewModel: viewModel, showOnlyFavorites: false)
                    .navigationTitle("All Companies")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { isShowingSettings = true }) {
                                Image(systemName: "gear")
                            }
                        }
                    }
            }
            .tabItem {
                Label("Companies", systemImage: "list.bullet")
            }
            
            NavigationView {
                CompanyListView(viewModel: viewModel, showOnlyFavorites: true)
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { isShowingSettings = true }) {
                                Image(systemName: "gear")
                            }
                        }
                    }
            }
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
            
            NavigationView {
                CompareView(viewModel: viewModel)
                    .navigationTitle("Compare")
            }
            .tabItem {
                Label("Compare", systemImage: "chart.bar.xaxis")
            }
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(viewModel: viewModel)
        }
    }
}

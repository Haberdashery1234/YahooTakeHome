//
//  SettingsView.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settings: AppSettings
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filter")) {
                    Toggle("Show only Favorites", isOn: $settings.showOnlyFavorites)
                        .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                }
                
                Section(header: Text("Sort Companies")) {
                    Picker("Sort Order", selection: $settings.sortBy) {
                        ForEach(AppSettings.SortType.allCases) { order in
                            Text(order.description).tag(order)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

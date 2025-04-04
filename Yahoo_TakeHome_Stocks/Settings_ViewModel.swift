//
//  Settings_ViewModel.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

class Settings_ViewModel: ObservableObject {
    // Use a private static key to avoid name conflicts
    private let sortOrderKey = "sortOrder"
    
    private let preferencesManager = PreferencesManager()

    // Backing storage (load/save manually)
    @Published var sortOrder: PreferencesManager.SortOrder {
        didSet {
            preferencesManager.saveSortOrder(sortOrder)
        }
    }

    init() {
        let savedValue = UserDefaults.standard.string(forKey: sortOrderKey)
        self.sortOrder = PreferencesManager.SortOrder(rawValue: savedValue ?? "") ?? .name
    }
}

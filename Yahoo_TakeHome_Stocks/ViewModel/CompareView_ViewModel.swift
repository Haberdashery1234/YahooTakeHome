//
//  CompareView_ViewModel.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/8/25.
//

import Foundation

extension CompareView {
    @Observable
    class ViewModel {
        var selectedCompanies: Set<Company>
        
        var companies: [Company] {
            Array(selectedCompanies)
        }
        
        init(selectedCompanies: Set<Company>) {
            self.selectedCompanies = selectedCompanies
        }
    }
}

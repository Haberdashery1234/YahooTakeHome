//
//  CompareView.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import SwiftUI

struct CompareView: View {
    @Binding private var selectedCompanies: Set<Company>
    @State private var viewModel: ViewModel
    
    init(selectedCompanies: Binding<Set<Company>>) {
        self._selectedCompanies = selectedCompanies
        self._viewModel = State(initialValue: ViewModel(selectedCompanies: selectedCompanies.wrappedValue))
    }
    
    var body: some View {
        VStack {
            if viewModel.companies.count >= 2 {
                VStack(spacing: 0) {
                    ComparisonChart(companies: viewModel.companies)
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                    ComparisonTable(companies: viewModel.companies)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                }
            } else {
                ContentUnavailableView {
                    Label("Select Companies", systemImage: "chart.bar.doc.horizontal")
                } description: {
                    Text("Select 2 or more companies to compare")
                } actions: {
                    Text("Tap companies in the list above")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .onChange(of: viewModel.selectedCompanies) { oldValue, newValue in
            // Update the binding when the view model changes
            if newValue != selectedCompanies {
                selectedCompanies = newValue
            }
        }
        .onChange(of: selectedCompanies) { oldValue, newValue in
            // Update the view model when the binding changes
            if newValue != viewModel.selectedCompanies {
                viewModel.selectedCompanies = newValue
            }
        }
    }
}

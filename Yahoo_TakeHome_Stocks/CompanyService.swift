//
//  StockFetcher.swift
//  Yahoo_TakeHome_StocksTests
//
//  Created by Christian Grise on 4/4/25.
//

import Foundation

class CompanyService {
    func fetchCompanyData() async throws -> [Company] {
        let urlString = "https://us-central1-fbconfig-90755.cloudfunctions.net/getAllCompanies"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
         
        let decoder = JSONDecoder()
        do {
            let companiesResponse = try decoder.decode([Company?].self, from: data)
            return companiesResponse.compactMap { $0 }
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}

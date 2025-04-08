//
//  Favorites.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/7/25.
//

import Foundation

@Observable
class Favorites {
    private var companies: Set<String>
    private let key = "Favorites"
    
    init() {
        guard let companyIDs = UserDefaults.standard.array(forKey: key) as? [String] else {
            companies = []
            return
        }

        companies = Set(companyIDs)
    }
    
    func allFavorites() -> Set<String> {
        return companies
    }
    
    func contains(_ company: Company) -> Bool {
        companies.contains(company.id)
    }
    
    func add(_ company: Company) {
        companies.insert(company.id)
        save()
    }
    
    func remove(_ company: Company) {
        companies.remove(company.id)
        save()
    }
    
    func save() {
        print(companies)
        UserDefaults.standard.set(Array(companies), forKey: key)
    }
}

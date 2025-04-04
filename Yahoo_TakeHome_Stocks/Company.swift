//
//  Company.swift
//  Yahoo_TakeHome_Stocks
//
//  Created by Christian Grise on 4/4/25.
//

import Foundation

struct MarketCap: Codable, Equatable {
    let fmt: String
    let longFmt: String
    let raw: Double
    
    enum CodingKeys: CodingKey {
        case fmt
        case longFmt
        case raw
    }
    
    static func == (lhs: MarketCap, rhs: MarketCap) -> Bool {
        lhs.raw == rhs.raw
    }
    
    static func < (lhs: MarketCap, rhs: MarketCap) -> Bool {
        lhs.raw < rhs.raw
    }
    
    static func > (lhs: MarketCap, rhs: MarketCap) -> Bool {
        lhs.raw > rhs.raw
    }
}

struct Company: Identifiable, Codable, Equatable {
    var id: String { symbol }
    let symbol: String
    let name: String
    let marketCap: MarketCap
    
    static func == (lhs: Company, rhs: Company) -> Bool {
        lhs.symbol == rhs.symbol
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case marketCap
    }
    
    static let example = Company(
        symbol: "AAPL",
        name: "Apple Inc.",
        marketCap: MarketCap(fmt: "$2.6 Trillion", longFmt: "$2.6 Trillion USD", raw: 2600000000000)
    )
}

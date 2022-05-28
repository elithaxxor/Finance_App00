//
//  SearchResults.swift
//  Financial_Calc_II
//
//  Created by a-robota on 4/20/22.
// https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo
// https://www.alphavantage.co/documentation/
// https://developer.apple.com/documentation/combine

// To match API calls to models
// json: bestMatches [symbol, name, type, region, marketopen/close, currency, score]
// works with: struct APIWorker 


import Foundation

// MARK: Model for indivdual Stock Details
struct SearchResults: Decodable {
    let allResults: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case allResults = "bestMatches"
    }
}


// MARK: Model mimicking json from API
struct SearchResult: Decodable {
    let name: String
    let symbol: String
    let type: String
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case name = "1. name"
        case symbol = "2. symbol"
        case type = "3. type"
        case currency = "8. currency"

    }
    
}

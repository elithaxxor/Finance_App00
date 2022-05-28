//
//  APIWorker.swift
//  Financial_Calc_II
//
//  Created by a-robota on 4/20/22.
// https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo
// https://www.alphavantage.co/documentation/
// https://developer.apple.com/documentation/combine 

// json: bestMatches [symbol, name, type, region, marketopen/close, currency, score]



import Foundation
import Combine

struct APIWorker {

    //MARK: Api Error Enum
    public enum APIError : Error {
        case encoding
        case badRequest
        case success
        case failure 
    } // error handling



    let KEYS = ["JXDQ2Z243AF8HZNV",
                "TF68YGON9AE136P1",
                "GNVDM55OKOT9SS7H",
                "HKZQMUJLUA18BL2Q"]

    var API_KEY: String { return KEYS.randomElement() ?? "" }


    // MARK: Logic for SearchResults model
    func fetchSymbols(keywords: String) -> AnyPublisher<SearchResults, Error> {

        let result = passQueryString(text: keywords)
        var queryString = String()
        switch result {
            case .success(let query):
                queryString = query
            case .failure(let error):
                return Fail(error:error).eraseToAnyPublisher()
        }

        let apiURL = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(keywords)&apikey=\(API_KEY)"
        guard let url = URL(string: apiURL) else { return Fail(error: APIError.badRequest).eraseToAnyPublisher() }
        let urlResult = parseURL(apiURL: apiURL)

        switch urlResult {
            case .success(let url):
                return URLSession.shared.dataTaskPublisher(for: url)
                    .map({ $0.data })
                    .decode(type: SearchResults.self, decoder: JSONDecoder())
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
        }

    }

    // MARK: Publisher for TimeByMonth Model
    func fetchMonthlyAdjustedObj(keywords : String) -> AnyPublisher<TimeByMonthModel, Error> {

        let result = passQueryString(text: keywords)
        var queryString = String()


        switch result {
            case .success(let query):
                queryString = query
            case .failure(let error):
                return Fail(error:error).eraseToAnyPublisher()
        }


        let apiURL = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(keywords)&apikey=\(API_KEY)"
        let parsedResult = parseURL(apiURL: apiURL)

        switch parsedResult {
            case .success(let url):
                return URLSession.shared.dataTaskPublisher(for: url)
                    .map({ $0.data })
                    .decode(type: TimeByMonthModel.self, decoder: JSONDecoder())
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
        }
    }




    private func passQueryString(text: String) -> Result<String, Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query) }
        else {
            return .failure(APIError.encoding)
        }
    }

    private func parseURL(apiURL: String) -> Result<URL, Error> {
        if let url = URL(string: apiURL) {
            return .success(url)
        } else {
            return .failure(APIError.badRequest)
        }
    }

}

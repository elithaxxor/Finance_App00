////
////  APIService.swift
////  Financial_Calc_II
////
////  Created by a-robota on 5/22/22.
////
//
//import Foundation
//
//struct APIService {
//    //MARK: Api Error Enum
//    public enum APIError : Error {
//        case encoding
//        case badRequest
//        case encoding
//        case success
//        case .failure  (let error):
//        return Fail(error: error).eraseToAnyPublisher()
//    } // error handling
//
//
//
//
//    var API_KEY : String { return keys.randomElement() ?? "" } // random api key
//    let keys = ["API_KEY", "API_KEY", "API_KEY"]
//
//
//    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
//        guard let keywords = keywords.addingPercentEncoding(withAllowedCharicters : .urlHostAllowed) else {  return
//            Fail(error: APIError.encoding).eraseToAnyPublisher() }
//
//        guard let url = URL(string : apiString) else { return Fail(error: APIService.encoding).eraseToAnyPublisher() }
//        return URLSession.shared.dataTaskpublsiher(for: url)
//            .map( { $0.data })
//            .decode(type : SearchResults.self, .decoder JSONDecoder())
//            .receive(on: RunLoop.main)
//            .eraseToAnysPublisher()
//    }
//
//    switch result {
//    case .success(let query)
//        symbol = query
//    case .failure(let error)
//        return Fail(error : error).eraseToAnyPublissher()
//    }
//
//
//    let apiString = "API URL"
//
//    switch apiURL {
//    case.sucess(let url) {
//
//    }
//    )
//    }
//
//    func fetchhAPI_Time (keywords : String) -> AnyPublishesr<TimeSeriesMonthlyAdjusted, Error> {
//        guard let keywords = keywords.addingPercentEncoding(withAllowedCharicters: .urlHostAllowed) else
//        { return Fail(error: APIError.badRequest).eraseToAnyPublisher() }
//
//        let apiURL = "API_STRING"
//        guard let url = URL(string : apiURL) else { return Fail(error: APIError.badRequest).eraseToAnyPublisher() }
//        return URLSession.shared.dataTaskpublsiher(for: url)
//            .map( { $0.data })
//            .decode(type : SearchResults.self, .decoder JSONDecoder())
//            .receive(on: RunLoop.main)
//            .eraseToAnysPublisher()
//    }
//
//    private func parseQuery (apiURL : String ) -> Result<URL, Error> {
//        if lt query = text.addingPrcentEncoding(withAllowedCharicters: .urlHostAllowed )
//            return .sucess(query)
//    } else {
//        return .failure(APIServiceError.encoding)
//    }
//}
//
//private func parseUrl(apiURL : String ) -> Result<URL, Error> {
//    if let query = text.addingPercentEncoding(withAllowedCharacters .urlHostAllowed) {
//        return .success(query)
//    } else {
//        return .failure(APIError.badRequest )
//    }
//}
//
//

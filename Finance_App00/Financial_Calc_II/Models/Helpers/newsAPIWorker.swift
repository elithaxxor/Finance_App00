//
//  NetworkManager.swift
//  HackerNews
//
//  Created by a-robota on 4/19/22.
//

// observableObject--> allows
// @Published--> simulates rss feed(update upon change) 
import Foundation


// https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2020-06-01/2020-06-17?apiKey=pnmVOrapMEyGBt2uOl2GBLKvM40CSjsD



// For Ticker Detail  /v3/reference/tickers/ {ticker}

// article_url*string for newspaper
// author*string The article's author.
// id*string
// descriptionstring

// Stock Split
// https://api.polygon.io/v3/reference/splits?apiKey=pnmVOrapMEyGBt2uOl2GBLKvM40CSjsD

// dividends
// https://api.polygon.io/v3/reference/dividends?apiKey=pnmVOrapMEyGBt2uOl2GBLKvM40CSjsD

// Stock Financials
// Stock Financials vX

/// https://api.polygon.io/vX/reference/financials?apiKey=pnmVOrapMEyGBt2uOl2GBLKvM40CSjsD

//published_utc*string
//The date the article was published on.
//
//publisher*object
//favicon_urlstring
//The publisher's homepage favicon URL.
//homepage_url*string
//The publisher's homepage URL.




struct newsAPIWorker {
    public enum newsAPIErr : Error {
        case encoding
        case badRequest
        case success
        case failure
    } // error handling


    let apikey = "pnmVOrapMEyGBt2uOl2GBLKvM40CSjsD"
    let urlStr = "https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2020-06-01/2020-06-17?apiKey=pnmVOrapMEyGBt2uOl2GBLKvM40CSjsD"
}








class NetworkManager: ObservableObject {

   @Published var posts = [Post]() // Post struct in PostData
    
    func fetch() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                
                if error == nil {
                    print("error not found, connecting sessions")
                    let decoder = JSONDecoder() // decodes PostData struct
                    if let safeData = data {
                        do {
                           let results =  try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async{ //.. 
                                self.posts = results.hits // sets state from json (.hits)
                            }

                    }
                    
     
                }
            }
            task.resume()
        }
    }
}


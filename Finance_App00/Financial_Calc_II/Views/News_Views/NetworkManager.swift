//
//  NetworkManager.swift
//  HackerNews
//
//  Created by a-robota on 4/19/22.
//

// observableObject--> allows
// @Published--> simulates rss feed(update upon change) 
import Foundation


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
                        } catch {
                            print(error)
                        }
                    }
                    
                } else {
                    print("error  found \(error)")
                }
            }
            task.resume()
        }
    }
}


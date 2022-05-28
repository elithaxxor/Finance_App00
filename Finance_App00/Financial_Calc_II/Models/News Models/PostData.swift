//
//  PostData.swift
//  HackerNews
//
//  Created by a-robota on 4/19/22.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
    
}

struct Post: Decodable, Identifiable {
    
    var id: String { // .. to use objectID (from .json fetch) as uniqueID 
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}

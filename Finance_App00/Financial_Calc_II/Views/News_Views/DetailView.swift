//
//  DetailView.swift
//  HackerNews
//
//  Created by a-robota on 4/19/22.
//

// displays details of url clicked

import SwiftUI
import WebKit
import Foundation

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlStr: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}

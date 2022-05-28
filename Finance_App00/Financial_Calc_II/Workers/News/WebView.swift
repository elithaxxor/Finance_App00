//
//  WebView.swift
//  HackerNews
//
//  Created by a-robota on 4/19/22.
//

import Foundation
import WebKit
import SwiftUI

// allows us to create a UIKitView (views for external webpage)
struct WebView: UIViewRepresentable {
    let urlStr: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeStr = urlStr {
            if let url = URL(string: safeStr){
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}


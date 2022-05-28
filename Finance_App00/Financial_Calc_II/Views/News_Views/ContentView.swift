////
////  ContentView.swift
////  HackerNews
////
////  Created by a-robota on 4/19/22.
//// @ObservedObject --> listener for
//
//import SwiftUI
//
//struct ContentView: View {
//    @ObservedObject var networkManager = NetworkManager() // copy NetworkManager protocol (listener for NetworkManager)
//    
//    var body: some View {
//        // Color("Background")
//        
//        NavigationView
//        
//        {
//            
//            List(networkManager.posts)
//            
//            { post in
//                // navigation link creates the ">" on UI, indicating a link is available 
//                NavigationLink(destination: DetailView(url: post.url)){
//                    Text(String(post.points))
//                    Text(post.title)
//                }
//            }
//            
//            .navigationTitle("H4XXOR NEWS")
//        }
//        
//        .onAppear{
//            self.networkManager.fetch() // auto-fetch (using method declared in NetworkManager)
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//// array to store news aggregatetion
//
//
////let posts = [
////    Post(id: "1", title: "title 1"),
////    Post(id: "2", title: "title 2"),
////    Post(id: "3", title: "title 3")
////]

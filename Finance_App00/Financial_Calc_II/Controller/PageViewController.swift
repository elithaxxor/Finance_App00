//
//  ContentView.swift
//  businessCard
//
//  Created by a-robota on 4/19/22.
// [CONVERTED PROJECT FROM SWIFTUI]

import SwiftUI
import UIKit



struct PageViewController<Page: View>: UIViewControllerRepresentable {
    
    var pages: [Page]

    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
        
        return Coordinator(self)
    }
    


    // [CREATE VIEW CONTROLLER]
    // Make View Control
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        return pageViewController
    }
    
    
    // Update View Control
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context){
        pageViewController.setViewControllers(
            [context.coordinator.controllers[0]], direction: .forward, animated: true)

    }

    class Coordinator: NSObject {
        var parent: PageViewController
        var controllers = [UIViewController]()


        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
    }
}



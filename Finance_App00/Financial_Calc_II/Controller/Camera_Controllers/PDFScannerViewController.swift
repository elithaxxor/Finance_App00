////
////  PDFScannerViewController.swift
////  Financial_Calc_II
////
////  Created by a-robota on 4/27/22.
////
//
//import UIKit
//import SwiftUI
//import PDFKit
//
//
//
//class ViewController : UIViewController, PDFViewDelegate {
//
//
//        // views
//        let PDFviewer = PDFView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(PDFviewer)
//        
//        PDFviewer.document = PDFDocument()  // obj to creat new pdf
//        view.addSubview(PDFviewer)
//        
//        // unwrapping doc creater [info from swfit docs]
//        // returns location and item in memory alotment. IE - fetch PDF doc.
//        guard let url = Bundle.main.url(forResource: "swiftui", withExtension: "pdf") else{
//            return
//        }
//        
//        //  sort of like an init(); crate documnt object
//        guard let document = PDFDocument(url : url) else {
//            return
//        }
//        PDFviewer.document = document
//        PDFviewer.delegate = self
//        
//        // Leveraging PDFviwer's methods
//        let newDocument = PDFDocument()
//      //  let page = PDFPage(image: UIImage(systemName:
//        
//    // must unwrap variable. make old page = new page.
//        guard let page = PDFPage(image: UIImage(systemName: "house")!) else {
//            return
//        }
//            
//        newDocument.insert(page, at: 0) // currently inserts at idx 0
//        PDFviewer.document = newDocument // erassignes the viewerapps parent to newDocumtn
//        
//    }
//    
//    override func viewDidLayoutSubviews(){
//    super.viewDidLayoutSubviews()
//        PDFviewer.frame = view.bounds
//    }
//
//
//}
//
//
//struct ContentView: View {
//   var body: some View {
//       ContentView()
//   }
//}

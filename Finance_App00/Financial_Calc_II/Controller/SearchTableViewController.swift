//
//  ViewController.swift
//  Financial_Calc_II
//
//  Created by a-robota on 4/20/22.
//
//
//  ViewController.swift
//  FinanceApp
//
//  Created by a-robota on 4/20/22.
//
//
// https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo
// https://www.alphavantage.co/documentation/
// https://developer.apple.com/documentation/combine


import UIKit
import Combine
import MBProgressHUD
import SwiftUI

@IBDesignable
class SearchTableViewController: TableViewControllerLogger, UIAnimatable {

    private enum Mode {
        case onboarding // homescreen (no search)
        case search // renders users result
    }
    
    // Class Instances //
    private let runAPI = APIWorker()
    private var subscribers = Set<AnyCancellable>() // for fetch
    private var searchResults: SearchResults? // return Models fetched from API

    @Published private var mode: Mode = .onboarding // UI state (onboarding or searcahing)
    @Published private var searchQuery = String() // search query (nav bar)



    // [ensures UISearchBar loads everytime]-- instantiates UISearchController
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter Company Name or $Ticker"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLogFile()
        NSLog("[LOGGING--> <START> [SEARCH VC]")

        setupNavBar()
        setupTableView() // FOR UI, when no search results.
        observeForm()
        NSLog("[LOGGING--> <END> [CALCULATOR VC]")

    }
    
    private func setupNavBar() {
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
    }
    
    
    @IBAction func calcBtn(_ sender: UIBarButtonItem) {
        print("[+] Segue to Basic Calcualtor")
        self.performSegue(withIdentifier: "toBasicCalc", sender: sender.action)

    }

    private func setupTableView(){
        tableView.tableFooterView = UIView() // removes lineitems on navviews
    }


    
    
    @IBAction func searchMenu (_ sender: UIBarButtonItem) {
        print(sender.title ?? "FIX ME [searchMenu Action]")
    }
    
    // [COMPANY SEARCH BOTTOM NAV ITEMS]
    @IBAction func searchNewsBtnPressed(_ sender: UIButton) {
        print("User pressed search new btn on Company Search, moving to news page")
        print (sender.buttonType)
        performSegue(withIdentifier: "search2newsBtn", sender: nil)
    }
    
    @IBAction func searchClassicCalc(_ sender: UIButton) {
        print("User pressed search new btn on Company Search, moving to calc page")
        print (sender.buttonType)

        performSegue(withIdentifier: "showClassicCalc", sender: nil)
    }
    

    // [DCF PAGE]
    @IBAction func dcf2News(_ sender: UIBarButtonItem) {
        print("User pressed search new btn on [DCF page,] moving to news ")
        performSegue(withIdentifier: "dcf2News", sender: nil)
    }
    @IBAction func dcf2Calc(_ sender: UIBarButtonItem) {
        print("User pressed search new btn on [DCF page], moving to [calc] ")
        performSegue(withIdentifier: "dcf2Calc", sender: nil)
    }
    

    
    // set up timer for response, while watches for Publisher to change [creates a waitingQueue (.debounce) on main thread) for NavBar in
    private func observeForm(){
        $searchQuery
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .sink { [ unowned self ] (searchQuery) in
                MBProgressHUD.showAdded(to: self.view, animated: true)
                guard !searchQuery.isEmpty else  { return }
                self.showLoadingAnimation()
                
                self.runAPI.fetchSymbols(keywords: searchQuery).sink { (completion) in
                    switch completion {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .finished: break
                    }
                } receiveValue: { ( searchResults) in
                    self.searchResults = searchResults
                    self.tableView.reloadData()
                    print(self.searchResults ?? "DEBUG ME--> SearchTable observeForm() ")
                }.store(in: &self.subscribers)
            }
        
        
        guard !searchQuery.isEmpty else {
            print("search navbar is empty")
            return
        }
        

        showLoadingAnimation()
        self.runAPI.fetchSymbols(keywords: searchQuery).sink { (completion) in
            switch completion {
                case .failure(let error):
                    print("Error, observedForm \(error)")
                    print(error.localizedDescription)

                case.finished: break
            }
        }
        
    receiveValue: { (searchResults ) in
        self.searchResults = searchResults
        self.tableView.reloadData() // maintains state ui persistance
        self.tableView.isScrollEnabled = true
    }.store(in: &subscribers)

        
        $mode.sink { [unowned self] (mode) in
            switch mode {
                case .onboarding:
                    self.tableView.backgroundView = nil
                case .search:
                    self.tableView.backgroundView = nil


            }
        }.store(in: &subscribers)

    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchTableViewCell
        if let searchResults = self.searchResults
        {
            let searchResult  = searchResults.allResults[indexPath.row]
            cell.configure(with: searchResult)
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.allResults.count ?? 0
    }

    // MARK: Segues into Stock Calculator screen
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let searchResults = self.searchResults {
            let searchResult = searchResults.allResults[indexPath.item]
            let symbol = searchResult.symbol

            handleSelection(for: symbol, searchResult: searchResult)
        }
    }

    // MARK: To handle indivdual cell seletion
    private func handleSelection(for symbol: String, searchResult: SearchResult) {
        showLoadingAnimation()
        runAPI.fetchMonthlyAdjustedObj(keywords: symbol).sink { [weak self] (completionResult) in
            self?.hideLoadingAnimation()
            switch completionResult {
                case.failure(let error):
                    print("[!] Error in hanlding CellView Selection \(error) ")
                case.finished:
                    print("[+] Completed Processing CellView Selection")
                    break
            }
        } receiveValue: { [weak self] (TimeByMonthModel) in
            print("perfomring segue transfer to DCA Calc")
            let asset = Asset(searchResults: searchResult, TimeByMonthModel: TimeByMonthModel)
            self?.performSegue(withIdentifier: "showCalculator", sender: asset)
            print("success \( TimeByMonthModel.getMonthInfo())")
        }.store(in: &subscribers)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if segue.identifier == "showCalcualtor",
           let destination = segue.destination as? CalculatorViewTableControllerViewController,
           let asset = sender as? Asset {
            destination.asset = asset
        }
    }
}


// [ Search Nav Bar  ]
extension SearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else { return }
        print("User Input \(searchQuery)")
        self.searchQuery = searchQuery
    }

    func willPresentSearchController(_ searchController: UISearchController) {
        print("switiching modes")
        mode = .search
    }
}



//
//  SearchTableViewCell.swift
//  Financial_Calc_II
//
//  Created by a-robota on 4/20/22.
// GNVDM55OKOT9SS7H
// https://www.alphavantage.co/documentation/

//.. To set values from API to individual tableview cells


import UIKit

@IBDesignable
class SearchTableViewCell: UITableViewCell {
    

    @IBOutlet weak var assetName: UILabel!
    @IBOutlet weak var assetSymbol: UILabel!
    @IBOutlet weak var assetType: UILabel!



    func configure(with searchResult: SearchResult){
        assetName.text = searchResult.name
        assetSymbol.text = searchResult.symbol
        assetType.text = searchResult.type
            .appending(" ")
            .appending(searchResult.currency)
    }
    
}

//
//  TimeByMonthModel.swift
//  Financial_Calc_II
//
//  Created by a-robota on 5/22/22.
//

/// The API Data received is dynamic, and changes as time passes; therefore model will remap values to avoid conflict.
///
/// The API returns an unsorted hashtable-- the program will sort the hashvalues based on time

///
import Foundation

struct MonthInfo {
    let date: Date
    let adjustedOpen : Double
    let adjustedClose : Double
}

struct OHLC : Decodable {
    let open : String
    let close : String
    let adjustedClose : String

    enum CodingKeys : String, CodingKey {
        case open = "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }
}


struct TimeByMonthModel : Decodable {
    let meta : Meta
    var timeSeries : [String : OHLC]

    enum CodingKeys: String, CodingKey {
        case meta = "Meta Data"
        case timeSeries = "Monthly Adusted Time Series"
    }

    func getMonthInfo() -> [MonthInfo] {
        var dates : [MonthInfo] = []
        let sortedTimeSeries = timeSeries.sorted(by : { $0.key > $1.key })
        sortedTimeSeries.forEach { (dateString, ohlc) in
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)!
            let adjustedOpen = getAdjustedOpen(ohlc: ohlc)
            let monthInfo = MonthInfo(date: date, adjustedOpen: adjustedOpen, adjustedClose: Double(ohlc.adjustedClose)!)
            dates.append(monthInfo)
        }
        print(" [+] Sorted API Hash Table \(sortedTimeSeries)")
        return dates
    }

    private func getAdjustedOpen(ohlc: OHLC) -> Double {
        return Double(ohlc.open)! * (Double(ohlc.adjustedClose)! / Double(ohlc.close)!)
    }
}


struct Meta : Decodable {
    let symbol: String
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}




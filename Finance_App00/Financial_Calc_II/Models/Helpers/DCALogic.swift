//
//  DCALogic.swift
//  Finance_App00
//
//  Created by a-robota on 5/27/22.
//

import Foundation

struct DCALogic {
    func calculate (startingAmount: Double, monthlyDCF: Double, investedDateIdx: Int, asset: Asset) -> calcualtedDCA {
        print("[+] Calculating  [invested date Idx] \(investedDateIdx) [Starting Amount] \(startingAmount) [Monthly DCF] \(monthlyDCF) ")
        // let asset = Asset(searchResults: SearchResult, TimeByMonthModel: TimeByMonthModel)

        let investmentAmount = calculateInvestedAmt(initialInvested: startingAmount,
                                                    monthlyDCF: monthlyDCF,
                                                    dateIdx: investedDateIdx)

        let sharePrice = totalEquityPrice(asset: asset)
        let totalEquityValue = totalEquityInventory(asset: asset,
                                                        initialInvestmentAmt: investmentAmount,
                                                        monthlyDCF: monthlyDCF,
                                                        dateIdx: investedDateIdx)

        let calculatedCurrentVal = calcCurrentVal(numberOfShares: totalEquityValue, sharePrice: sharePrice)
        let calculatedGain = calculatedCurrentVal - totalEquityValue.convertInt2Double

        let calulcatedYield = calcYield(investedAmt: investmentAmount,
                                        gain: calculatedGain,
                                        monthlyDCF: monthlyDCF,
                                        dateIdx: investedDateIdx)


        let isProfitable = sharePrice > calculatedCurrentVal

        let calculatedAnnualReturn = calculateAnnualReturn(investmentAmount: investmentAmount,
                                                           totalEquityValue: calculatedCurrentVal,
                                                           dateIdx: investedDateIdx)


        print("[+][+] Calculated Totals: [(Individual) Asset Price] \(sharePrice)")
        print("[+][+] Calculated Totals: [(Total) Equity in holdings] \(totalEquityValue)")
        print("[+][+] Calculated Totals: [calculatedCurrentVal] \(calculatedCurrentVal)")
        print("[+][+] Calculated Totals: [Calculated Yield] \(calulcatedYield)")
        print("[+][+] Calculated Totals: [Investment Amount] : \(investmentAmount)")
        print("[+][+] Calculated Totals: [calculated Annual Return] : \(calculatedAnnualReturn)")

        print("[+][+] Calculated Totals: [gain] : \(calculatedGain)")
        print("[+][+] Calculated Totals: [is Profitable?] : \(isProfitable)")



        return .init(
            currentVal: calculatedCurrentVal,
            investedAmt: investmentAmount,
            gain: calculatedGain,
            yield: calulcatedYield,
            annualReturn: calculatedAnnualReturn,
            isProfitable: isProfitable)
    }

    //MARK: Calculate Annual Return
    private func calculateAnnualReturn(investmentAmount: Double, totalEquityValue: Double, dateIdx: Int  ) -> Double {
        var annualReturn = Double()
        let rate = totalEquityValue / investmentAmount
        let years = ((dateIdx + 1) / 12).convertInt2Double
        annualReturn = pow(rate, (1 / years )) - 1

        print("[+] Calculating Annual Return : \(dateIdx) [\(investmentAmount)] *  [\(totalEquityValue)] ")
        print("[+] Calculating using..  : *[rate] \(rate) *[years] [\(investmentAmount)] *  [\(totalEquityValue)] ")
        print("[+] Calculating [RESULTS] * [\(annualReturn)] * ")

        return annualReturn
    }



    // currentValue = currentSharesHeld * SharePrice [initial investment]
    private func calcCurrentVal(numberOfShares: Int, sharePrice: Double) -> Double {
        print("[+] Calculating Current Share Holdings using: [\(numberOfShares)] *  [\(sharePrice)] ")
        let totalShareValues = numberOfShares.convertInt2Double * sharePrice

        print("[!] Calcualted Total Share Values : \(totalShareValues)")


        return totalShareValues
    }


    private func totalEquityPrice(asset: Asset) -> Double {
        let equityPrice = asset.TimeByMonthModel.getMonthInfo().first?.adjustedClose ?? 0.0

        print("[+] Stock Helper--> Grabbing Latest Asset Price ")
        print("[+] Stock Helper--> [adjusted close] \(String(describing: asset.TimeByMonthModel.getMonthInfo().first?.adjustedClose))")
        print("[+] Stock Helper--> [adjusted Open] \(String(describing: asset.TimeByMonthModel.getMonthInfo().first?.adjustedOpen))")

        print("[!] Calulcated Stock Price--> \(equityPrice)")
        return equityPrice
    }

    private func totalEquityInventory(asset: Asset, initialInvestmentAmt: Double, monthlyDCF: Double, dateIdx: Int) -> Int {
        var totalEquity = Double()

        let openingPrice = asset.TimeByMonthModel.getMonthInfo()[dateIdx].adjustedOpen
        totalEquity += openingPrice
        let shares = initialInvestmentAmt / openingPrice

        asset.TimeByMonthModel.getMonthInfo().prefix(dateIdx).forEach{ (_) in
            let DCA = monthlyDCF / openingPrice
            totalEquity += DCA
        }
        print("[+] Stock Helper--> Grabbing Amount of Equity Held \(initialInvestmentAmt) \(monthlyDCF) ")
        print("[+] Stock Helper--> [Total Equities Held] \(totalEquity)")
        print("[+] Stock Helper--> [opening price] \(totalEquity)")
        print("[+] Stock Helper--> [Shares] \(shares)")

        return Int(Double(totalEquity))
    }


    private func calculateInvestedAmt(initialInvested: Double, monthlyDCF: Double, dateIdx: Int) -> Double {
        var total = Double()
        total += initialInvested
        let DCF = dateIdx.convertInt2Double * monthlyDCF
        total += DCF
        print("[Calculate Total Amt] : \(total)")
        return total
    }


    // MARK: Calcualte the yield (% of gains)
    private func calcYield(investedAmt: Double, gain: Double, monthlyDCF: Double, dateIdx: Int ) -> Double {
        print("[+] Calculate Yield Formula — calculated as the net realized return divided by the principal amount")
        var totalYield = Double()
        totalYield += investedAmt / investedAmt
        return totalYield
    }
}

struct calcualtedDCA {
    let currentVal : Double
    let investedAmt : Double
    let gain : Double
    let yield : Double
    let annualReturn : Double
    let isProfitable : Bool
}

//
//  DateSelectionTableViewController.swift
//  Finance_App00
//
//  Created by a-robota on 5/26/22.
//

import UIKit

@IBDesignable
class DateSelectionTableViewController: TableViewControllerLogger {

    var TimeByMonthModel: TimeByMonthModel?
    private var monthInfos: [MonthInfo] = []
    var didSelectDate: ((Int) -> Void)?
    var selectedIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        createLogFile()
        NSLog("[LOGGING--> <START> [DATE-SELECTION VC]")

        setupViews()
        setupHeader()
        setupMonthInfos()
        
        NSLog("[LOGGING--> <END> [DATE-SELECTION VC]")

    }

    private func setupViews() {
        if let monthInfos = TimeByMonthModel?.getMonthInfo() {
            self.monthInfos = monthInfos
        }
    }
    private func setupHeader() {
        self.title = "Select Date"
    }
    private func setupMonthInfos() {
        monthInfos = TimeByMonthModel?.getMonthInfo() ?? []
    }
}

extension DateSelectionTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeByMonthModel?.getMonthInfo().count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let monthInfo = monthInfos[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DateSelectionCell
        let index = indexPath.item
        let isSelected = index == selectedIndex
        cell.configure(monthInfo: monthInfo, index: index, isSelected: isSelected)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectDate!(indexPath.item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class DateSelectionCell : UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!

    func configure(monthInfo: MonthInfo, index: Int, isSelected: Bool) {
        backgroundColor = .darkGray
        dateLabel.text = monthInfo.date.dateFormatter
        accessoryType = isSelected ? .checkmark : .none

        if index == 1 {
            dateLabel.text = "A Month Ago"
        }
        else if index > 1 {
            dateLabel.text = "[\(index)] Months Ago"
        } else {
            dateLabel.text = "THERES A BUG IN DATE-SELECTION CELL, FIX ME :["
        }
    }
}

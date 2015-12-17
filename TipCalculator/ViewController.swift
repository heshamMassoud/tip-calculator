//
//  ViewController.swift
//  TipCalculator
//
//  Created by Hesham Massoud on 11/12/15.
//  Copyright © 2015 Hesham Massoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var taxPercentageSlider: UISlider!
    @IBOutlet weak var taxPercentageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let tipCalc = TipCalculatorModel(total: 33.25, taxPercantage: 0.06)
    var possibleTips = Dictionary<Int, (tip: Double, totalWithTip: Double)>()
    var sortedKeys: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func refreshUI() {
        totalBillTextField.text = String(tipCalc.total)
        taxPercentageSlider.value = Float(tipCalc.taxPercantage)*100.0
        taxPercentageLabel.text = "Tax Percentage (\(Int(taxPercentageSlider.value))%)"
    }

    @IBAction func calculateButtonTapped(sender: AnyObject) {
        tipCalc.total = Double((totalBillTextField.text! as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sort()
        tableView.reloadData()
    }

    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPercantage = Double(taxPercentageSlider.value) / 100.0
        refreshUI()
    }

    @IBAction func viewTapped(sender: AnyObject) {
        totalBillTextField.resignFirstResponder()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        let currentRow = indexPath.row
        let tipPercentage = sortedKeys[currentRow]
        let tipAmount = possibleTips[tipPercentage]!.tip
        let totalAmountWithTip = possibleTips[tipPercentage]!.totalWithTip

        cell.textLabel?.text = "\(tipPercentage)%:"
        cell.detailTextLabel?.text = String(format:"Tip: $%0.2f, Total: $%0.2f", tipAmount, totalAmountWithTip)
        return cell
    }

}

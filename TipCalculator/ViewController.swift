//
//  ViewController.swift
//  TipCalculator
//
//  Created by Hesham Massoud on 11/12/15.
//  Copyright © 2015 Hesham Massoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tipCalc = TipCalculatorModel(total: 33.25, taxPercantage: 0.06)

    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var taxPercentageSlider: UISlider!
    @IBOutlet weak var taxPercentageLabel: UILabel!
    @IBOutlet weak var resultsTextView: UITextView!

    @IBAction func calculateButtonTapped(sender: AnyObject) {
        tipCalc.total = Double((totalBillTextField.text! as NSString).doubleValue)
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        for (tipPercentage, tipValue) in possibleTips {
            results += "\(tipPercentage)%: \(tipValue)\n"
        }
        resultsTextView.text = results
    }

    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPercantage = Double(taxPercentageSlider.value) / 100.0
        refreshUI()
    }

    @IBAction func viewTapped(sender: AnyObject) {
        totalBillTextField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshUI() {
        totalBillTextField.text = String(tipCalc.total)
        taxPercentageSlider.value = Float(tipCalc.taxPercantage) * 100.0
        taxPercentageLabel.text = "Tax Percentage (\(Int(taxPercentageSlider.value))%)"
        resultsTextView.text = ""
    }

}

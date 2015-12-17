//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Hesham Massoud on 11/12/15.
//  Copyright © 2015 Hesham Massoud. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    var total: Double
    var taxPercantage: Double
    var subTotal: Double {
        get {
            return total / (taxPercantage + 1)
        }
    }
    
    init(total: Double, taxPercantage: Double) {
        self.total = total
        self.taxPercantage = taxPercantage
    }
    
    func calcTipWithTipPercantage(tipPercantage: Double) -> Double {
        return subTotal * tipPercantage
    }
    
    func returnPossibleTips() -> [Int: Double] {
        let possibleTips = [0.15, 0.18, 0.20]
        var returnValue = [Int: Double]()
        for possibleTip in possibleTips {
            let intPercantage = Int(possibleTip * 100)
            returnValue[intPercantage] = calcTipWithTipPercantage(possibleTip)
        }
        return returnValue
    }
}

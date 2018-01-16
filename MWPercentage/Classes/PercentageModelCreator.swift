//
//  PercentageModelCreator.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 30.10.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

class PercentageModelCreator: NSObject {
    
    
    static func getPercentageModel(with name:String, percentage:Int, theme:PercentageTheme, font:PercentageFont, indicatorSize:CGSize? = nil) -> PercentageModel {
        
        let model = PercentageModel()
        
        model.name = name
        
        model.percentage = percentage
        
        model.percentageTheme = theme
        
        model.percentageFont = font
        
        model.percentageIndicatorSize = indicatorSize
        
        return model
    }
}


extension UIColor {
    
    static func colorWith(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        
        return UIColor(red: red/256.0, green: green/256.0, blue: blue/256.0, alpha: 1.0)
        
    }
}

extension PercentageModel {
    func getRate() -> NSNumber{
        let formatter = NumberFormatter.init()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.minimumIntegerDigits = 1
        let rateValue = String(format: "%.2f", Double(self.percentage) / 100)
        if let newValue = formatter.number(from: rateValue) {
            return newValue
        }else{//safe
            let doubleValue = Double(self.percentage) / 100
            return NSNumber.init(value: doubleValue)
        }
        
    }
}



//
//  PercentageDefaultFonts.swift
//  YGPercentage
//
//  Created by Yilmaz Gursoy on 15.01.2018.
//  Copyright © 2018 Yilmaz Gursoy. All rights reserved.
//

import UIKit

let defaultFontName = "Helvetica Neue"

class PercentageFont: NSObject {
    
    static let defaultFont = PercentageFont()
    
    static let shared = PercentageFont()
    
    var percentageFont = UIFont(name: defaultFontName, size: 12)!
    
    var percentageNameFont = UIFont(name: defaultFontName, size: 12)!
    
    var bottomPercentageFont = UIFont(name: defaultFontName, size: 10)!
 
    var rulerFont = UIFont(name: defaultFontName, size: 12)!
    
    func setSharedFonts(withPercentageFont percentage:UIFont, percentageName:UIFont, bottomPercentage:UIFont, ruler:UIFont) {
        self.percentageFont = percentage
        self.percentageNameFont = percentageName
        self.bottomPercentageFont = bottomPercentage
        self.rulerFont = ruler
    }
    
}


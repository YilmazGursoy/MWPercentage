//
//  PercentageDefaultFonts.swift
//  YGPercentage
//
//  Created by Yilmaz Gursoy on 15.01.2018.
//  Copyright © 2018 Yilmaz Gursoy. All rights reserved.
//

import UIKit

let defaultFontName = "Helvetica Neue"

public class PercentageFont: NSObject {
    
    public static let defaultFont = PercentageFont()
    
    public static let shared = PercentageFont()
    
    public var percentageFont = UIFont(name: defaultFontName, size: 12)!
    
    public var percentageNameFont = UIFont(name: defaultFontName, size: 12)!
    
    public var bottomPercentageFont = UIFont(name: defaultFontName, size: 10)!
 
    public var rulerFont = UIFont(name: defaultFontName, size: 12)!
    
    public func setSharedFonts(withPercentageFont percentage:UIFont, percentageName:UIFont, bottomPercentage:UIFont, ruler:UIFont) {
        self.percentageFont = percentage
        self.percentageNameFont = percentageName
        self.bottomPercentageFont = bottomPercentage
        self.rulerFont = ruler
    }
    
}


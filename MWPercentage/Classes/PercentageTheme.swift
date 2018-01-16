//
//  PercentageThemes.swift
//  YGPercentage
//
//  Created by Yilmaz Gursoy on 15.01.2018.
//  Copyright © 2018 Yilmaz Gursoy. All rights reserved.
//

import UIKit

let darkGrayColor:UIColor = UIColor.colorWith(red: 55, green: 55, blue: 55)
let rulerSmallIndicatorColor:UIColor = UIColor.colorWith(red: 240, green: 240, blue: 240)

let blueThemeColor:UIColor = UIColor.colorWith(red: 98, green: 204, blue: 226)
let greenThemeColor:UIColor = UIColor.colorWith(red: 171, green: 216, blue: 155)
let yellowThemeColor:UIColor = UIColor.colorWith(red: 251, green: 196, blue: 99)
let redThemeColor:UIColor = UIColor.colorWith(red: 251, green: 99, blue: 99)

class PercentageTheme: NSObject {
    
    static let shared = PercentageTheme()
    var pColor = UIColor.white
    var pTextColor = UIColor.white
    var pBackColor = UIColor.white
    var pLeftIndicatorColor = UIColor.white
    var pNameTextColor = darkGrayColor
    var bottomPColor = UIColor.white
    var bottomPNameTextColor = darkGrayColor
    var pSeperatorColor = UIColor.white
    var pRulerBackColor = UIColor.white
    var pRulerTextColor = darkGrayColor
    var pRulerIndicatorsColor = darkGrayColor.withAlphaComponent(0.5)
    var pRulerSmallIndicatorColor = rulerSmallIndicatorColor
    var pIndicatorSize:CGSize = CGSize(width: 30, height: 30)
    override init() {
        
    }
    
    func setGlobalColors(withSeperatorColor seperatorColor:UIColor,rulerTextColor rulerColor:UIColor, rulerIndicatorColor indicatorColor:UIColor, rulerSmallIndicatorColor smallIndicatorColor:UIColor, indicatorSize:CGSize? = nil) {
        self.pSeperatorColor = seperatorColor
        self.pRulerTextColor = rulerColor
        self.pRulerIndicatorsColor = indicatorColor
        self.pRulerSmallIndicatorColor = smallIndicatorColor
        if ( indicatorSize != nil ) {
            self.pIndicatorSize = indicatorSize!
        } else {
            self.pIndicatorSize = CGSize(width: 30, height: 30)
        }
        
    }
}

class BlueTheme:PercentageTheme {
    static let defaultTheme = BlueTheme()
    override var pColor:UIColor {
        get {
            return blueThemeColor
        } set{
            self.pColor = newValue
        }
    }
    override var pBackColor:UIColor {
        get {
            return blueThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    override var pLeftIndicatorColor:UIColor {
        get{
            return blueThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    override var bottomPColor:UIColor {
        get {
            return blueThemeColor
        }set{
            self.bottomPColor = newValue
        }
    }
}

class GreenTheme: PercentageTheme {
    static let defaultTheme = GreenTheme()
    override var pColor:UIColor {
        get {
            return greenThemeColor
        } set{
            self.pColor = newValue
        }
    }
    override var pBackColor:UIColor {
        get {
            return greenThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    
    override var pLeftIndicatorColor:UIColor {
        get {
            return greenThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    
    override var bottomPColor :UIColor {
        get {
            return greenThemeColor
        } set{
            self.bottomPColor = newValue
        }
    }
}

class YellowTheme: PercentageTheme {
    static let defaultTheme = YellowTheme()
    override var pColor :UIColor {
        get {
            return yellowThemeColor
        } set{
            self.pColor = newValue
        }
    }
    override var pBackColor:UIColor {
        get {
            return yellowThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    override var pLeftIndicatorColor:UIColor {
        get {
            return yellowThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    override var bottomPColor:UIColor {
        get {
            return yellowThemeColor
        } set{
            self.bottomPColor = newValue
        }
    }
}

class RedTheme: PercentageTheme {
    static let defaultTheme = RedTheme()
    override var pColor:UIColor {
        get {
            return redThemeColor
        } set{
            self.pColor = newValue
        }
    }
    override var pBackColor:UIColor {
        get {
            return redThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    override var pLeftIndicatorColor:UIColor {
        get {
            return redThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    override var bottomPColor:UIColor {
        get {
            return redThemeColor
        } set{
            self.bottomPColor = newValue
        }
    }
}

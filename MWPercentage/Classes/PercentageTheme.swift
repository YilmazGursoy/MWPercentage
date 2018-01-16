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

public class PercentageTheme: NSObject {
    
    public static let shared = PercentageTheme()
    public var pColor = UIColor.white
    public var pTextColor = UIColor.white
    public var pBackColor = UIColor.white
    public var pLeftIndicatorColor = UIColor.white
    public var pNameTextColor = darkGrayColor
    public var bottomPColor = UIColor.white
    public var bottomPNameTextColor = darkGrayColor
    public var pSeperatorColor = UIColor.white
    public var pRulerBackColor = UIColor.white
    public var pRulerTextColor = darkGrayColor
    public var pRulerIndicatorsColor = darkGrayColor.withAlphaComponent(0.5)
    public var pRulerSmallIndicatorColor = rulerSmallIndicatorColor
    public var pIndicatorSize:CGSize = CGSize(width: 30, height: 30)
    public override init() {
        
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

public class BlueTheme:PercentageTheme {
    public static let defaultTheme = BlueTheme()
    public override var pColor:UIColor {
        get {
            return blueThemeColor
        } set{
            self.pColor = newValue
        }
    }
    public override var pBackColor:UIColor {
        get {
            return blueThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    public override var pLeftIndicatorColor:UIColor {
        get{
            return blueThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    public override var bottomPColor:UIColor {
        get {
            return blueThemeColor
        }set{
            self.bottomPColor = newValue
        }
    }
}

public class GreenTheme: PercentageTheme {
    public static let defaultTheme = GreenTheme()
    public override var pColor:UIColor {
        get {
            return greenThemeColor
        } set{
            self.pColor = newValue
        }
    }
    public override var pBackColor:UIColor {
        get {
            return greenThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    
    public override var pLeftIndicatorColor:UIColor {
        get {
            return greenThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    
    public override var bottomPColor :UIColor {
        get {
            return greenThemeColor
        } set{
            self.bottomPColor = newValue
        }
    }
}

public class YellowTheme: PercentageTheme {
    public static let defaultTheme = YellowTheme()
    public override var pColor :UIColor {
        get {
            return yellowThemeColor
        } set{
            self.pColor = newValue
        }
    }
    public override var pBackColor:UIColor {
        get {
            return yellowThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    public override var pLeftIndicatorColor:UIColor {
        get {
            return yellowThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    public override var bottomPColor:UIColor {
        get {
            return yellowThemeColor
        } set{
            self.bottomPColor = newValue
        }
    }
}

public class RedTheme: PercentageTheme {
    public static let defaultTheme = RedTheme()
    public override var pColor:UIColor {
        get {
            return redThemeColor
        } set{
            self.pColor = newValue
        }
    }
    public override var pBackColor:UIColor {
        get {
            return redThemeColor.withAlphaComponent(0.3)
        } set{
            self.pBackColor = newValue
        }
    }
    public override var pLeftIndicatorColor:UIColor {
        get {
            return redThemeColor
        } set{
            self.pLeftIndicatorColor = newValue
        }
    }
    public override var bottomPColor:UIColor {
        get {
            return redThemeColor
        } set{
            self.bottomPColor = newValue
        }
    }
}

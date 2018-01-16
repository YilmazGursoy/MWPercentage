//
//  PercentageModel.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 30.10.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

class PercentageModel: NSObject {
    var name = ""
    var percentage = 0
    var percentageString = ""
    var percentageFloat:Double = 0.0
    var percentageTheme:PercentageTheme = BlueTheme() //Default Theme
    var percentageFont:PercentageFont!
    var percentageIndicatorSize:CGSize!
}

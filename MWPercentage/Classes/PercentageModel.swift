//
//  PercentageModel.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 30.10.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

public class PercentageModel: NSObject {
    public var name = ""
    public var percentage = 0
    public var percentageString = ""
    public var percentageFloat:Double = 0.0
    public var percentageTheme:PercentageTheme = BlueTheme() //Default Theme
    public var percentageFont:PercentageFont!
    public var percentageIndicatorSize:CGSize!
}

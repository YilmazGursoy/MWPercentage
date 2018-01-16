//
//  GraphScaleView.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 1.11.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

class GraphScaleView: UIView {

    
    static func createAndGetScaleView(withSuperView superView:UIView) -> GraphScaleView {
        
        let scaleBackView = GraphScaleView(frame: CGRect(x: superView.bounds.width-40, y: 0, width: 40, height: superView.bounds.height))
        scaleBackView.backgroundColor = PercentageTheme.shared.pRulerBackColor
    
        //MARK: Adding First BlackViews
        let stepValue = superView.bounds.height / 10
        let smallStepValue = stepValue / 4
        var firstY:CGFloat = 0.0
        for index in 0...10 {
            
            if index == 10 {
                firstY = firstY - 2
            }
            
            let stepView = UIView(frame: CGRect(x: 0, y: firstY, width: 10, height: 1))
            stepView.backgroundColor = PercentageTheme.shared.pRulerIndicatorsColor
            
            let scaleLabel = UILabel(frame: CGRect(x: stepView.frame.origin.x+stepView.bounds.width+5, y: 0, width: 30, height: 40))
            scaleLabel.font = PercentageFont.shared.rulerFont
            scaleLabel.tintColor = PercentageTheme.shared.pRulerSmallIndicatorColor
            scaleLabel.textAlignment = .left
            scaleLabel.center = CGPoint(x: scaleLabel.center.x, y: stepView.center.y)
            scaleLabel.text = "\(100 - 10*index)"
            
            var smallYValue = firstY + smallStepValue
            //MARK: Create Small Scale Indicators
            if index != 10 {
                for value in 1...3 {
                    if value == 1 || value == 3 {
                        let smallStepView = UIView(frame: CGRect(x: 0, y: smallYValue, width: 10, height: 1))
                        smallStepView.backgroundColor = PercentageTheme.shared.pRulerSmallIndicatorColor
                        scaleBackView.addSubview(smallStepView)
                        
                    } else {
                        let smallStepView = UIView(frame: CGRect(x: 0, y: smallYValue, width: 30, height: 1))
                        smallStepView.backgroundColor = PercentageTheme.shared.pRulerSmallIndicatorColor
                        scaleBackView.addSubview(smallStepView)
                    }
                    smallYValue = smallYValue + smallStepValue
                }

            }
            firstY = firstY + stepValue
            scaleBackView.addSubview(stepView)
            scaleBackView.addSubview(scaleLabel)
            
            
        }
        return scaleBackView
    }
}

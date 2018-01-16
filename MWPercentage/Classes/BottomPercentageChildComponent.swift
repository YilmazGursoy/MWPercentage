//
//  BottomPercentageChildComponent.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 7.11.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit



class BottomPercentageChildComponent: UIView {
    private var totalWidth:CGFloat = 40
    private var padding:CGFloat = 4.0
    var percentageLabel:UILabel!
    var percentageColor:UIColor!
    var percentageModel:PercentageModel!
    
    func getChildComponent(withPercentage model:PercentageModel) -> BottomPercentageChildComponent {
        totalWidth = getPercentageBackViewWidth(withPercentage: "%\(model.percentage)0000")
        if self.bounds.width >= totalWidth {
            
            let xValue = (self.bounds.width - ( totalWidth + padding )) / 2
            let percentageColorView = UIView(frame: CGRect(x: xValue, y: 2, width: (getPercentageBackViewHeight(withPercentage: "%\(model.percentage)0000")-2)*1.5, height: getPercentageBackViewHeight(withPercentage: "%\(model.percentage)0000")-2))
            percentageColorView.layer.cornerRadius = 1.0
            percentageColorView.backgroundColor = model.percentageTheme.bottomPColor
            
            self.addSubview(percentageColorView)
            
            self.percentageModel = model
            self.percentageLabel = UILabel(frame: CGRect(x: xValue+percentageColorView.bounds.width+padding, y: 0, width: totalWidth, height: getPercentageBackViewHeight(withPercentage: "%\(model.percentage)0000")))
            self.percentageLabel.font = PercentageFont.shared.bottomPercentageFont
            self.percentageLabel.textColor = PercentageTheme.shared.bottomPNameTextColor
            self.percentageLabel.text = "%\(model.percentage)"
            self.addSubview(self.percentageLabel)
        }
        return self
    }
    
    func setNewBottomPercentageChildModel(newModel: PercentageModel) {
        
        self.percentageLabel.text = "%\(newModel.percentage)"
        
    }
    
    func setZero(){
        self.percentageLabel.text = "%0"
    }
    
    func getPercentageBackViewHeight(withPercentage percentage:String) -> CGFloat{
        return percentage.height(withConstrainedWidth: 100, font: PercentageFont.shared.bottomPercentageFont)
    }
    
    func getPercentageBackViewWidth(withPercentage percentage:String) -> CGFloat{
        return  percentage.width(withConstrainedHeight: 100, font: PercentageFont.shared.bottomPercentageFont)
    }
}

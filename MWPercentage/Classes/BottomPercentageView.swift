//
//  BottomPercentageView.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 7.11.2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit



class BottomPercentageView: UIView {
    private var bottomPercentageWidth:CGFloat = 60.0
    private var totalWidth:CGFloat = 45.0
    var allBottomPercentageChilds:[BottomPercentageChildComponent] = []
    static let shared = BottomPercentageView()
    
    func createBottomPercentage(withSuperView superView:UIView, andPercentageModels models:[PercentageModel]) -> BottomPercentageView {
        bottomPercentageWidth = getPercentageBackViewWidth(withPercentage: "%\(100)000") * CGFloat(models.count)
        totalWidth = getPercentageBackViewWidth(withPercentage: "%\(100)000")
        
        if( self.subviews.count != 0 ) {
            for subview in self.subviews {
                subview.clearBottomPercentageChildComponent()
            }
        }
        self.frame = superView.bounds
        let modelsToPrint = models
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: totalWidth * CGFloat(models.count) + CGFloat(4), height: superView.bounds.height))
        self.allBottomPercentageChilds.removeAll()
        for (index,model) in modelsToPrint.enumerated() {
            let bottomPercentage:BottomPercentageChildComponent = BottomPercentageChildComponent(frame: CGRect(x: CGFloat(index) * totalWidth, y: 0, width:totalWidth, height: getPercentageBackViewHeight(withPercentage:"%0000")))
            allBottomPercentageChilds.append(bottomPercentage)
            backView.addSubview(bottomPercentage.getChildComponent(withPercentage: model))
        }
        self.addSubview(backView)
        backView.center = self.center
        return self
    }
    
    func getPercentageBackViewHeight(withPercentage percentage:String) -> CGFloat{
        return percentage.height(withConstrainedWidth: 100, font: PercentageFont.shared.bottomPercentageFont)
    }
    
    func getPercentageBackViewWidth(withPercentage percentage:String) -> CGFloat{
        return  percentage.width(withConstrainedHeight: 15, font: PercentageFont.shared.bottomPercentageFont)
    }
    
}

extension UIView
{
    func clearBottomPercentageChildComponent()
    {
        for subview in self.subviews as! [BottomPercentageChildComponent] {
            subview.removeFromSuperview();
        }
    }
}

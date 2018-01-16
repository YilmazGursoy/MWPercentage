//
//  PercentageChildView.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 30.10.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

let shadowHeight:CGFloat = 1.0
let bottomValuesPadding:CGFloat = 20.0

enum PercentageChildViewUpdateType {
    case Above
    case Below
}

protocol PercentageChildViewDelegate {
    func update(percentageModel model:PercentageModel)
}

class PercentageChildView: UIView {
    
    var nameLabel:UILabel!
    var percentageLabel:UILabel!
    var percentageBackView:UIView!
    var leftIndicatorView:UIView!
    var bottomBorderView:UIView!
    var numberOfShadowSeperator = 5
    var percentageChildModel:PercentageModel!
    var percentageBackViewHeight:CGFloat!
    var percentageBackViewWidth:CGFloat!
    var delegate:PercentageChildViewDelegate!
    var isZero = false
    
    override func draw(_ rect: CGRect) {
        if self.percentageBackView != nil && self.nameLabel != nil {
            if( !self.isZero ) {
                self.bottomBorderView.frame = CGRect(x: 0, y: self.bounds.height-1, width:self.bounds.width, height: 1)
            } else {
                self.frame.size.height = 0.0
                self.bottomBorderView.frame = CGRect(x: 0, y: self.bounds.height-1, width:self.bounds.width, height: 0)
            }
            self.percentageBackView.center = CGPoint(x:percentageBackView.center.x,y:self.bounds.height/2)
            self.nameLabel.center = CGPoint(x:nameLabel.center.x,y:self.bounds.height/2)
            self.leftIndicatorView.frame = CGRect(x: 0, y: 0, width: 2, height: self.bounds.height)
            calculatePercentageLabel()
        }
    }
    
    func getPercentageChildView(with model:PercentageModel) -> PercentageChildView {
        self.percentageChildModel = model
        self.percentageBackView = UIView(frame: CGRect(x: 7, y: 0, width: getPercentageBackViewWidth(withPercentage: "%\(model.percentage)1"), height: getPercentageBackViewHeight(withPercentage: "%\(model.percentage)1")+10))
        self.percentageBackView.backgroundColor = model.percentageTheme.pColor
        self.backgroundColor = model.percentageTheme.pBackColor
        self.leftIndicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: self.bounds.height))
        self.leftIndicatorView.backgroundColor = model.percentageTheme.pColor
        self.addSubview(self.leftIndicatorView)
        
        //MARK: BottomBorderView
        self.bottomBorderView = UIView(frame: CGRect(x: 0, y: self.bounds.height-1, width:self.bounds.width, height: 1))
        self.bottomBorderView.backgroundColor = UIColor.white
        self.addSubview(self.bottomBorderView)
        
        //MARK: Percentage label creation
        self.percentageBackView.center = CGPoint(x:percentageBackView.center.x,y:self.bounds.height/2)
        self.percentageBackView.layer.cornerRadius = 4.0
        self.percentageLabel = UILabel(frame: CGRect(x: 3, y: 5, width: getPercentageBackViewWidth(withPercentage: "%\(model.percentage)1"), height: getPercentageBackViewHeight(withPercentage: "%\(model.percentage)1")))
        self.percentageLabel.font = PercentageFont.shared.percentageFont
        self.percentageLabel.textColor = model.percentageTheme.pTextColor
        self.percentageLabel.textAlignment = .center
        self.percentageLabel.text = "%\(model.percentage)"
        
        //MARK: Set Label Frame Size
        let size = self.percentageLabel.sizeThatFits(CGSize(width: 150, height: 10))
        var frame = self.percentageLabel.frame
        frame.size.width = size.width
        self.percentageLabel.frame = frame
        frame = self.percentageBackView.frame
        frame.size.width = self.percentageLabel.frame.size.width
        self.percentageBackView.frame = frame
        
        self.percentageBackView.addSubview(percentageLabel)
        self.addSubview(self.percentageBackView)
        
        self.nameLabel = UILabel(frame: CGRect(x: percentageBackView.frame.origin.x + self.percentageLabel.bounds.width + 20, y: 0, width: 200, height: 20))
        self.nameLabel.center = CGPoint(x:nameLabel.center.x,y:self.bounds.height/2)
        self.nameLabel.font = PercentageFont.shared.percentageNameFont
        self.nameLabel.textColor = model.percentageTheme.pNameTextColor
        self.nameLabel.text = model.name
        self.addSubview(self.nameLabel)
        
        self.setNeedsLayout()
        self.setNeedsDisplay()
        
        return self
    }
 
    //MARK: Private Methods
    
    func calculatePercentageLabel(){
        
        let percentage = CGFloat(100 * self.bounds.height) / (((self.superview?.bounds.height)! - bottomValuesPadding))
        self.percentageLabel.text = "%\(Int(round(percentage)))"
        
        //MARK: Set Label Frame Size
        let size = self.percentageLabel.sizeThatFits(CGSize(width: 150, height: 10))
        var frame = self.percentageLabel.frame
        frame.size.width = size.width
        self.percentageLabel.frame = frame
        frame = self.percentageBackView.frame
        frame.size.width = getPercentageBackViewWidth(withPercentage: "\(self.percentageLabel.text!)1")
        self.percentageBackView.frame = frame
        
        if self.percentageChildModel != nil {
            self.percentageChildModel.percentage = Int(round(percentage))
            self.percentageChildModel.percentageString = self.percentageLabel.text!
        }
        
        if self.delegate != nil {
            self.delegate.update(percentageModel: self.percentageChildModel)
        }
    }
    
    func updateAllPercentageModels(withPercentageChildViews childViews:[PercentageChildView]) {
        
        var percentageModels:[PercentageModel] = []
        
        for childView in childViews {
            
            if childView.isZero {
                childView.percentageChildModel.percentage = 0
                childView.percentageChildModel.percentageString = "%0"
            }
            if childView.percentageChildModel.isEqual(self.percentageChildModel) {
                childView.percentageChildModel.percentageString = self.percentageLabel.text!
            }
            percentageModels.append(childView.percentageChildModel)
        }
    }
    
    static func updatePercentageFrames(withPercentageChildView childView:PercentageChildView, andChangedPoint point:CGPoint, andType type:PercentageChildViewUpdateType, andUpdatingHiddenChildViewsList hiddenList:[PercentageChildView], allChilds childs:[PercentageChildView]) {
        
        var newChildView:PercentageChildView!
        
        for childV in childs {
            if childV.isEqual(childView) {
                newChildView = childV
            }
        }
        
        let frame = newChildView.frame
        var newFrame:CGRect!
        switch type {
            case .Above:
                newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: abs(point.y) - frame.origin.y)
                break
            case .Below:
                let belowLastYValue = frame.origin.y+frame.height
                newFrame = CGRect(x: frame.origin.x, y: point.y, width: frame.size.width, height: belowLastYValue-point.y)
                break
        }
        
        newChildView.frame = newFrame
        for hiddenView in hiddenList {
            if !hiddenView.isEqual(newChildView) {
                if type == .Above {
                    hiddenView.frame = CGRect(x: newFrame.origin.x, y: frame.origin.y+newFrame.size.height, width: hiddenView.frame.size.width, height: 0.0)
                    hiddenView.setNeedsDisplay()
                } else if type == .Below {
                    hiddenView.frame = CGRect(x: newFrame.origin.x, y: point.y, width: hiddenView.frame.size.width, height: 0.0)
                    hiddenView.setNeedsDisplay()
                }
            }
        }
        
        if newChildView.frame.height <= 0 {
            newChildView.isZero = true
            newChildView.isHidden = true
            newChildView.setNeedsDisplay()
        } else {
            newChildView.isZero = false
            newChildView.isHidden = false
            newChildView.setNeedsDisplay()
        }
        
        //TODO: Make Dynamic
        if( newChildView.frame.height < newChildView.percentageBackViewHeight + 10 ) {
            newChildView.nameLabel.isHidden = true
            newChildView.percentageBackView.isHidden = true
            
        } else {
            newChildView.nameLabel.isHidden = false
            newChildView.percentageBackView.isHidden = false
        }
        if type == .Below {
            newChildView.updateAllPercentageModels(withPercentageChildViews: childs)
        }
        
        newChildView.setNeedsDisplay()

    }
    //MARK: Helper
    func refreshHiddenChildViewParameters(){
        if self.percentageBackView != nil && self.nameLabel != nil {
            if( !self.isZero ) {
                self.bottomBorderView.frame = CGRect(x: 0, y: self.bounds.height-1, width:self.bounds.width, height: 1)
            } else {
                self.frame.size.height = 0.0
                self.bottomBorderView.frame = CGRect(x: 0, y: self.bounds.height-1, width:self.bounds.width, height: 0)
            }
            self.percentageBackView.center = CGPoint(x:percentageBackView.center.x,y:self.bounds.height/2)
            self.nameLabel.center = CGPoint(x:nameLabel.center.x,y:self.bounds.height/2)
            self.leftIndicatorView.frame = CGRect(x: 0, y: 0, width: 2, height: self.bounds.height)
            calculatePercentageLabel()
        }
    }
    
    func getPercentageBackViewHeight(withPercentage percentage:String) -> CGFloat{
        if self.percentageBackViewWidth != nil {
            self.percentageBackViewHeight = percentage.height(withConstrainedWidth: self.percentageBackViewWidth, font: PercentageFont.shared.percentageFont)
            return self.percentageBackViewHeight
        } else {
            self.percentageBackViewHeight = percentage.height(withConstrainedWidth: 100, font: PercentageFont.shared.percentageFont)
            return self.percentageBackViewHeight
        }
    }
    
    func getPercentageBackViewWidth(withPercentage percentage:String) -> CGFloat{
        if self.percentageBackViewHeight != nil {
            self.percentageBackViewWidth = percentage.width(withConstrainedHeight: self.percentageBackViewHeight, font: PercentageFont.shared.percentageFont)
            return self.percentageBackViewWidth
        } else {
            self.percentageBackViewWidth = percentage.width(withConstrainedHeight: 100, font: PercentageFont.shared.percentageFont)
            return self.percentageBackViewWidth
        }
    }
    
    
}


//
//  MWPercentage.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 30.10.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

struct RuntimeError: Error {
    let message: String
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}

public class MWPercentage: UIView {
    var allChilds:[PercentageChildView] = []
    var allIndicatorCenters:[CGPoint] = []
    var allIndicators:[GraphIndicator] = []
    var bottomPercentageView:UIView!
    public var allGraphModels:[PercentageModel] = []
    var allBottomChilds:[BottomPercentageChildComponent]!
    var bottomHeight:CGFloat!
    
    public func createGraph(withView view:UIView, andPercentageModels models:[PercentageModel]) -> MWPercentage {
        let percentageGraph = MWPercentage(frame: view.bounds)
        var yValue = 0.0
        setCustomFonts(model:models.last!)
        self.bottomHeight = getPercentageBackViewHeight(withPercentage: "%0000")
        self.allGraphModels = models
        self.bottomPercentageView = UIView(frame: CGRect(x: 0, y: view.bounds.height-bottomHeight, width: view.bounds.width, height: bottomHeight))
        self.bottomPercentageView.backgroundColor = UIColor.white
       
        self.bottomPercentageView.clearSubviews()
        self.bottomPercentageView.addSubview(BottomPercentageView.shared.createBottomPercentage(withSuperView: self.bottomPercentageView, andPercentageModels: allGraphModels))
        self.allBottomChilds = BottomPercentageView.shared.allBottomPercentageChilds
        
        let graphIndicatorAndChildViewsBackView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height-bottomValuesPadding))
        
        percentageGraph.addSubview(self.bottomPercentageView)
        
        
        createIndicatorsAboveBelow(withNumberOfCount: models.count)
        var controlTotalPercentage = 0
        for (index,model) in models.enumerated() {
            
            let height = (Double(model.percentage) * Double(graphIndicatorAndChildViewsBackView.bounds.height)) / 100
            PercentageTheme.shared.setGlobalColors(withSeperatorColor: model.percentageTheme.pSeperatorColor, rulerTextColor: model.percentageTheme.pRulerTextColor, rulerIndicatorColor: model.percentageTheme.pRulerIndicatorsColor, rulerSmallIndicatorColor: model.percentageTheme.pRulerSmallIndicatorColor, indicatorSize: model.percentageIndicatorSize)
            let percChild = PercentageChildView.init(frame: CGRect(x: 0.0, y: yValue, width: Double(graphIndicatorAndChildViewsBackView.bounds.width-50), height: height))
            let percChildView = percChild.getPercentageChildView(with: model)
            percChildView.delegate = self
            allChilds.append(percChildView)
            self.allIndicatorCenters.append(CGPoint(x: percChildView.bounds.width, y: CGFloat(yValue + height)))
            controlTotalPercentage += model.percentage
            percentageGraph.addSubview(percChildView)
            yValue = yValue + height
            
            for (indicatorIndex,stepIndicator) in self.allIndicators.enumerated() {
                
                if index <= indicatorIndex {
                    stepIndicator.aboveChildGraphs.append(percChildView)
                } else {
                    stepIndicator.belowChildGraphs.append(percChildView)
                }
                
            }
        }
        
        if controlTotalPercentage != 100 {
            fatalError("Please make sure your model has a total of 100 values // KING")
        }
        
        createIndicators(withGraphView: graphIndicatorAndChildViewsBackView)
        let scaleView = GraphScaleView.createAndGetScaleView(withSuperView: graphIndicatorAndChildViewsBackView)
        percentageGraph.addSubview(scaleView)
        percentageGraph.sendSubview(toBack: scaleView)
        percentageGraph.addSubview(graphIndicatorAndChildViewsBackView)
        
        return percentageGraph
    }
    
    //MARK: CreateIndicators
    func createIndicators(withGraphView graphView:UIView){
        var newIndicators:[GraphIndicator] = []
        for (index,center) in allIndicatorCenters.enumerated() {
            
            if center == allIndicatorCenters.last {
                break
            }
            let graphIndicator = GraphIndicator(frame: CGRect(x: 0, y: 0, width: 50, height: 50)).createIndicator(withIndicatorCenter: center, andSuperRects: graphView.frame)
            graphIndicator.aboveChildGraphs = self.allIndicators[index].aboveChildGraphs
            graphIndicator.belowChildGraphs = self.allIndicators[index].belowChildGraphs
            graphIndicator.delegate = self
            newIndicators.append(graphIndicator)
            graphView.addSubview(graphIndicator)
        }
        self.allIndicators = newIndicators
    }
    
    //MARK: Private method
    func createIndicatorsAboveBelow(withNumberOfCount numberOf:Int){
    
        for _ in 0..<numberOf {
            let indicator = GraphIndicator()
            self.allIndicators.append(indicator)
        }
        
    }
    
    func getPercentageBackViewHeight(withPercentage percentage:String) -> CGFloat{
        return percentage.height(withConstrainedWidth: 100, font: PercentageFont.shared.bottomPercentageFont) * 0.7
    }
    
    func setCustomFonts(model:PercentageModel) {
        PercentageFont.shared.setSharedFonts(withPercentageFont: model.percentageFont.percentageFont, percentageName: model.percentageFont.percentageNameFont, bottomPercentage: model.percentageFont.bottomPercentageFont, ruler: model.percentageFont.rulerFont)
    }
    
    func changePercentage(aboveChildView aboveViewList:[PercentageChildView], andBelowChildView belowViewList:[PercentageChildView], changedPoint:CGPoint) {
        
        PercentageChildView.updatePercentageFrames(withPercentageChildView: aboveViewList.last!,andChangedPoint: changedPoint, andType: .Above, andUpdatingHiddenChildViewsList: aboveViewList, allChilds: self.allChilds)
        PercentageChildView.updatePercentageFrames(withPercentageChildView: belowViewList.last!,andChangedPoint: changedPoint, andType: .Below, andUpdatingHiddenChildViewsList: belowViewList, allChilds: self.allChilds)
    }
    
    func getAboveChildView(fromAboveList list:[PercentageChildView], andDirection direction:IndicatorDirection) -> [PercentageChildView] {
        var aboveList:[PercentageChildView] = []
        if direction == .Up {
            
            for value in list.reversed().enumerated() {
                
                if value.element.isZero == false {
                    aboveList.append(value.element)
                    
                    return aboveList
                } else {
                    
                    aboveList.append(value.element)
                }
                
            }
            
            return [list.last!]
            
        } else {
            
            return [list.last!]
        
        }
    }
    
    func getBelowChildView(fromBelowList list:[PercentageChildView], andDirection direction:IndicatorDirection) -> [PercentageChildView] {
        var belowList:[PercentageChildView] = []
        if direction == .Down {
            
            for value in list.enumerated() {
                
                if value.element.isZero == false {
                    belowList.append(value.element)
                    
                    return belowList
                } else {
                    belowList.append(value.element)
                    
                }
            }
            return [list.first!]
            
        } else {
            
            return [list.first!]
            
        }
        
    }
    
    func rearrageAboveAndBelowChildViews(withAboveList aboveList:[PercentageChildView], andBelowList belowList:[PercentageChildView], andPosition position:CGPoint, finallyDirection direction:IndicatorDirection) {
        
        if direction == .Down {
            
            for belowChildView in belowList {
                
                if (belowChildView.frame.origin.y + CGFloat(round(100*belowChildView.bounds.height)/100)) <= position.y {
                    
                    belowChildView.isZero = true
                    belowChildView.isHidden = true
                    belowChildView.refreshHiddenChildViewParameters()
                    belowChildView.frame = CGRect(x: belowChildView.frame.origin.x, y: position.y, width: belowChildView.bounds.width, height: 0.0)
                    
                } else if (belowChildView.frame.origin.y + belowChildView.bounds.height) > position.y && belowChildView.frame.contains(position) {
                    let firstOrigin = belowChildView.frame.origin.x
                    belowChildView.frame = CGRect(x: firstOrigin, y: position.y, width: belowChildView.bounds.width, height: belowChildView.bounds.height - (position.y - belowChildView.frame.origin.y))
                }
                
                belowChildView.setNeedsDisplay()
            }
            
        } else if direction == .Up {
            
            for aboveChildView in aboveList {
                
                if aboveChildView.frame.origin.y >= position.y {
                    
                    aboveChildView.isZero = true
                    aboveChildView.isHidden = true
                    aboveChildView.refreshHiddenChildViewParameters()
                    aboveChildView.frame = CGRect(x: aboveChildView.frame.origin.x, y: position.y, width: aboveChildView.bounds.width, height: 0.0)
                    
                } else if aboveChildView.frame.origin.y < position.y && aboveChildView.frame.contains(position) {
                    
                    aboveChildView.frame = CGRect(x: aboveChildView.frame.origin.x, y: aboveChildView.frame.origin.y, width: aboveChildView.bounds.width, height: position.y - aboveChildView.frame.origin.y)
                    
                }
                aboveChildView.setNeedsDisplay()
            }
        }
    }
}

extension MWPercentage:GraphIndicatorProtocol {
    
    func graphIndicatorChange(indicatorPosition position: CGPoint, andIndicator indicator: GraphIndicator, andDirection direction: IndicatorDirection) {
        

        if position.y >= 0 && position.y <= ((indicator.aboveChildGraphs.last?.superview?.frame.size.height)!-bottomValuesPadding) + (indicator.aboveChildGraphs.last?.superview?.frame.origin.y)! {
            
            rearrageAboveAndBelowChildViews(withAboveList: indicator.aboveChildGraphs, andBelowList: indicator.belowChildGraphs, andPosition: position, finallyDirection: direction)
            changePercentage(aboveChildView: getAboveChildView(fromAboveList: indicator.aboveChildGraphs, andDirection: direction), andBelowChildView:getBelowChildView(fromBelowList: indicator.belowChildGraphs, andDirection: direction), changedPoint: position)
        }
        
        for (_,stepIndicator) in self.allIndicators.enumerated() {
            stepIndicator.isHidden =  ((stepIndicator.frame.contains(position)) && !stepIndicator.isEqual(indicator))
            if let aboveChildView = stepIndicator.aboveChildGraphs.last {
                stepIndicator.center = CGPoint(x: aboveChildView.bounds.width, y: aboveChildView.frame.origin.y+aboveChildView.bounds.height)
                if controlIfAllAboveChildViewsZero(withList: stepIndicator.aboveChildGraphs) == false {
                    if aboveChildView.isZero == true {
                        stepIndicator.isHidden = true
                    } else {
                        stepIndicator.isHidden = false
                    }
                }
            }
        }
    }
    
    //MARK: Private Method
    func controlIfAllAboveChildViewsZero(withList list:[PercentageChildView]) -> Bool{
        var isAllValuesZero = true
        for childValue in list {
            if childValue.isZero == false{
                isAllValuesZero = false
            }
        }
        return isAllValuesZero
    }
}

extension MWPercentage:PercentageChildViewDelegate {
    
    func update(percentageModel model:PercentageModel) {
        
        for bottomChilds in self.allBottomChilds {
           
            if bottomChilds.percentageModel.name == model.name {
                
                bottomChilds.setNewBottomPercentageChildModel(newModel: model)
                
            } else {
                if model.percentage == 100 {
                    bottomChilds.setZero()
                }
            }
            
        }
        
    }
    
}

extension UIView
{
    func clearSubviews()
    {
        for subview in self.subviews as! [BottomPercentageView] {
            subview.removeFromSuperview();
        }
    }
}

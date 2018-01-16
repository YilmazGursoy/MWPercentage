//
//  StepPointsHelper.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 3.11.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

class StepPointsHelper: NSObject {
    
    static let shared = StepPointsHelper()
    
    func getNearestStepPoint(withSuperRect rect:CGRect, andCurrentPoint point:CGPoint) -> CGPoint {
        var nearestDif = rect.height
        var nearestPoint : CGPoint = CGPoint.zero
        let list = getStepsPointList(withSuperViewRect: rect, andPoint: point)
        
        for nearestStep in list {

            if nearestDif > fabs(nearestStep.y - point.y) {
                nearestDif = fabs(nearestStep.y - point.y)
                nearestPoint = nearestStep
            }
            
        }
    
        return nearestPoint
    }
    
    //MARK: Private Method
    private func getStepsPointList(withSuperViewRect rect:CGRect, andPoint point:CGPoint) -> [CGPoint] {
        
        let stepValue = rect.height / 100.0
        var allPointList:[CGPoint] = []
        for step in 0...100 {
            allPointList.append(CGPoint(x: point.x, y: CGFloat(step) * stepValue))
        }
        return allPointList
    }
    
}

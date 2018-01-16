//
//  GraphIndicator.swift
//  ParaminKaptani
//
//  Created by Yilmaz Gursoy on 31.10.2017.
//  Copyright © 2017 YG. All rights reserved.
//

import UIKit

enum IndicatorDirection {
    case Up
    case Down
}

protocol GraphIndicatorProtocol {
    func graphIndicatorChange(indicatorPosition position:CGPoint, andIndicator indicator:GraphIndicator, andDirection direction:IndicatorDirection)
}

class GraphIndicator: UIView {
    
    var aboveChildGraphs:[PercentageChildView] = []
    var belowChildGraphs:[PercentageChildView] = []
    var superViewRect:CGRect!
    var delegate:GraphIndicatorProtocol!
    var indicatorImageView:UIImageView!
    
    func createIndicator(withIndicatorCenter center:CGPoint, andSuperRects superViewRect:CGRect) -> GraphIndicator {
        self.backgroundColor = UIColor.clear
        self.indicatorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: PercentageTheme.shared.pIndicatorSize.width, height: PercentageTheme.shared.pIndicatorSize.height))
        self.indicatorImageView.isUserInteractionEnabled = false
        self.isUserInteractionEnabled = true
        self.indicatorImageView.contentMode = .scaleAspectFit
        self.superViewRect = superViewRect
        self.center = center
        self.indicatorImageView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        self.indicatorImageView.image = getIndicatorImage(fileName: "iconSlider")
        self.indicatorImageView.layer.shadowColor = UIColor.colorWith(red: 53, green: 53, blue: 53).withAlphaComponent(0.3).cgColor
        self.indicatorImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.indicatorImageView.layer.shadowOpacity = 0
        self.indicatorImageView.layer.shadowRadius = 4
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
        self.addSubview(self.indicatorImageView)
        return self
        
    }
    
    func getIndicatorImage(fileName:String)->UIImage {
        let path = Bundle(for: MWPercentage.self).path(forResource: "MWPercentage", ofType: "bundle")
        let bundle = Bundle(path: path!)
        let imagePath = bundle?.path(forResource: fileName, ofType: "png")
        let url = NSURL(fileURLWithPath: imagePath!)
        let data = NSData(contentsOf: url as URL)
        if let data = data {
            return UIImage(data: data as Data)!
        }
        return UIImage()
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: self.superview)
        let direction = translation.y < 0 ? IndicatorDirection.Up : IndicatorDirection.Down
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed || gestureRecognizer.state == .ended {
            
                // note: 'view' is optional and need to be unwrapped
                if gestureRecognizer.view!.center.y + translation.y < self.superViewRect.size.height + self.superViewRect.origin.y && gestureRecognizer.view!.center.y + translation.y > 0 {
                    let newStepYValue = StepPointsHelper.shared.getNearestStepPoint(withSuperRect: self.superViewRect, andCurrentPoint: CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.location(in: self.superview).y))
                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: newStepYValue.y)
                    gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                    if self.delegate != nil {
                        self.delegate.graphIndicatorChange(indicatorPosition: CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y), andIndicator:gestureRecognizer.view! as! GraphIndicator, andDirection: direction)
                    }
            }
    }
    
    }
    
}

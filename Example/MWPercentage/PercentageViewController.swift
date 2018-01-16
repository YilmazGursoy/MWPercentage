//
//  PercentageViewController.swift
//  YGPercentage
//
//  Created by Yilmaz Gursoy on 15.01.2018.
//  Copyright © 2018 Yilmaz Gursoy. All rights reserved.
//

import UIKit
import MWPercentage

enum DemoTypes {
    case Default
    case CustomColors
    case CustomFonts
    case WithoutBottomPercentage
}

class PercentageViewController: UIViewController {
    
    @IBOutlet weak var percentageView: UIView!
    var type:DemoTypes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.createGraph()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createGraph(){
        
        switch type {
        case .Default:
            let model1 = PercentageModelCreator.getPercentageModel(with: "Dolar", percentage: 30, theme: BlueTheme.defaultTheme, font: PercentageFont.defaultFont)
            let model2 = PercentageModelCreator.getPercentageModel(with: "Euro", percentage: 20, theme: GreenTheme.defaultTheme, font: PercentageFont.defaultFont)
            let model3 = PercentageModelCreator.getPercentageModel(with: "Yen", percentage: 40, theme: YellowTheme.defaultTheme, font: PercentageFont.defaultFont)
            let model4 = PercentageModelCreator.getPercentageModel(with: "Pound", percentage: 10, theme: RedTheme.defaultTheme, font: PercentageFont.defaultFont)
            self.percentageView.addSubview(MWPercentage(frame: self.percentageView.frame).createGraph(withView: self.percentageView, andPercentageModels: [model1, model2, model3, model4]))
            
        case .CustomColors:
            let customRed = UIColor.colorWith(red: 250, green: 17, blue: 79)
            let customOrange = UIColor.colorWith(red: 255, green: 59, blue: 48)
            let customBrown = UIColor.colorWith(red: 255, green: 149, blue: 0)
            let customYellow = UIColor.colorWith(red: 255, green: 230, blue: 32)
            let customGreen = UIColor.colorWith(red: 4, green: 222, blue: 113)
            
            
            let model1 = PercentageModelCreator.getPercentageModel(with: "Dolar", percentage: 10, theme: generateThemeWithColor(withColor: customRed), font: PercentageFont.defaultFont)
            let model2 = PercentageModelCreator.getPercentageModel(with: "Euro", percentage: 10, theme: generateThemeWithColor(withColor: customOrange), font: PercentageFont.defaultFont)
            let model3 = PercentageModelCreator.getPercentageModel(with: "Yen", percentage: 15, theme: generateThemeWithColor(withColor: customBrown), font: PercentageFont.defaultFont)
            let model4 = PercentageModelCreator.getPercentageModel(with: "Pound", percentage: 15, theme: generateThemeWithColor(withColor: customYellow), font: PercentageFont.defaultFont)
            let model5 = PercentageModelCreator.getPercentageModel(with: "TRL", percentage: 10, theme: generateThemeWithColor(withColor: customGreen), font: PercentageFont.defaultFont)
            let model6 = PercentageModelCreator.getPercentageModel(with: "Euro2", percentage: 10, theme: GreenTheme.defaultTheme, font: PercentageFont.defaultFont)
            let model7 = PercentageModelCreator.getPercentageModel(with: "Yen2", percentage: 15, theme: YellowTheme.defaultTheme, font: PercentageFont.defaultFont)
            let model8 = PercentageModelCreator.getPercentageModel(with: "Pound2", percentage: 15, theme: RedTheme.defaultTheme, font: PercentageFont.defaultFont)
            self.percentageView.addSubview(MWPercentage(frame: self.percentageView.frame).createGraph(withView: self.percentageView, andPercentageModels: [model1, model2, model3, model4,model5,model6, model7, model8]))
        case .CustomFonts:
            let customFont = PercentageFont()
            customFont.percentageFont = UIFont(name: "Helvetica Neue", size: 20)!
            customFont.percentageNameFont = UIFont(name: "Helvetica Neue", size: 20)!
            customFont.rulerFont = UIFont(name: "Helvetica Neue", size: 15)!
            customFont.bottomPercentageFont = UIFont(name: "Helvetica Neue", size: 18)!
            
            let model1 = PercentageModelCreator.getPercentageModel(with: "Dolar", percentage: 30, theme: BlueTheme.defaultTheme, font: customFont,indicatorSize: CGSize(width: 50, height: 50))
            let model2 = PercentageModelCreator.getPercentageModel(with: "Euro", percentage: 20, theme: GreenTheme.defaultTheme, font: customFont,indicatorSize: CGSize(width: 50, height: 50))
            let model3 = PercentageModelCreator.getPercentageModel(with: "Yen", percentage: 40, theme: YellowTheme.defaultTheme, font: customFont,indicatorSize: CGSize(width: 50, height: 50))
            let model4 = PercentageModelCreator.getPercentageModel(with: "Pound", percentage: 10, theme: RedTheme.defaultTheme, font: customFont,indicatorSize: CGSize(width: 50, height: 50))
            self.percentageView.addSubview(MWPercentage(frame: self.percentageView.frame).createGraph(withView: self.percentageView, andPercentageModels: [model1, model2, model3, model4]))
        default:
            print("Hello")
        }
        
    }
    
    //MARK: Theme Generator
    func generateThemeWithColor(withColor color:UIColor) -> PercentageTheme {
        let customTheme = PercentageTheme()
        customTheme.pColor = color
        customTheme.pBackColor = color.withAlphaComponent(0.3)
        customTheme.pTextColor = UIColor.black
        customTheme.pNameTextColor = UIColor.black
        customTheme.pSeperatorColor = UIColor.white.withAlphaComponent(0.2)
        customTheme.pLeftIndicatorColor = color
        customTheme.bottomPColor = color
        return customTheme
    }
}


//
//  ViewController.swift
//  YGPercentage
//
//  Created by Yilmaz Gursoy on 11.01.2018.
//  Copyright © 2018 Yilmaz Gursoy. All rights reserved.
//

import UIKit
import MWPercentage

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    let types = ["Default", "Custom colors","Custom Fonts"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = types[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let percentageVC = storyboard?.instantiateViewController(withIdentifier: "PercentageViewController") as! PercentageViewController
        switch indexPath.row {
        case 0:
            percentageVC.type = DemoTypes.Default
        case 1:
            percentageVC.type = DemoTypes.CustomColors
        case 2:
            percentageVC.type = DemoTypes.CustomFonts
        case 3:
            percentageVC.type = DemoTypes.WithoutBottomPercentage
        default:
            print("Default")
        }
        
        self.navigationController?.pushViewController(percentageVC, animated: true)
    }
    
}

//
//  ViewController.swift
//  CompoundBarChart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit

class Sample {
    let period : [Double] = [40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]
    
    let lifestyleSpending : [Double] = [500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000]
    
    let socialSecurity : [Double] = [400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    let pension : [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,132454.2986,129131.1739,125891.4226,122732.9528,119653.7254,116651.7523,113725.0951,110871.8644,108090.218,105378.3598,102734.539,100157.0486,97644.22449,95194.44418,92806.12601,90477.72798]
    
    let socialSecurity_Real : [Double] = [0,0,0,0,0,0,0,0,110,110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,46660.70091,45490.03806,44348.74578,43236.0872,42151.34393,41093.81561,40062.81946,39057.68979,38077.77767,37122.4504,36191.09119]
    
    let portfolioSpending : [Double] = [100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,500000,500000,500000,500000,500000,500000,500000,250000,250000,250000,250000,250000,150000,150000,150000,150000,150000,150000,150000,150000,150000,150000,150000]
    
    let portfolioReserve : [Double] = [100000,100000,100000,100000,100000,100000,100000,100000,500000,500000,100000,100000,100000,100000,100000,100000,100000,100000,500000,500000,500000,500000,500000,500000,500000,367545.7014,370868.8261,374108.5774,377267.0472,380346.2746,336687.5468,340784.8668,344779.3898,348673.6948,352470.2962,356171.6454,359780.1319,363298.0857,366727.7782,370071.4236,373331.1808]
}


class ViewController: UIViewController {

    @IBOutlet weak var bar1: CompoundBar!
    @IBOutlet weak var bar2: CompoundBar!
    
    @IBOutlet weak var circle1: Circle!
    @IBOutlet weak var circle2: Circle!
    
    @IBOutlet weak var area: Area!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        area.model = Area.Model(
            Back: [
                Area.Element( Values: Sample().lifestyleSpending, Color: UIColor.grayColor())
            ],
            
            Rows: [
                Area.Element( Values: Sample().pension, Color: UIColor.blueColor()),
                Area.Element( Values: Sample().socialSecurity, Color: UIColor.greenColor()),
                Area.Element( Values: Sample().portfolioSpending, Color: UIColor.orangeColor()),
                Area.Element( Values: Sample().socialSecurity_Real, Color: UIColor.purpleColor()),
                Area.Element( Values: Sample().portfolioReserve, Color: UIColor.cyanColor()),
            ]
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let animate = true
    
//    
//    let v1 : [Double] = [99, 1]
//    let v2 : [Double] = [80, 1000]
//    let v3 : [Double] = [50, 40]
//    let t1 : [Double] = [20, 40]
//    let t2 : [Double] = [20, 100]
//    let t3 : [Double] = [0, 100]
//    
    let v1 : [Double] = [20, 40,  100, 56,  90,  20,  30 ]
    let v2 : [Double] = [80, 1000,10,  0,   30,  400, 50 ]
    let v3 : [Double] = [10, 40,  10,  300, 200, 100, 300]
    let t1 : [Double] = [20, 40,  180, 156, 90,  20,  30 ]
    let t2 : [Double] = [20, 100,10,  0,   30,  40, 50 ]
    let t3 : [Double] = [40, 80,  152,  30, 20, 100, 300]
    
    @IBAction func b1(sender: AnyObject) {
        bar1.setValues(v1, animated: animate)
        bar2.setValues(t1, animated: animate)
        
        circle1.userData = v1
        circle2.userData = t1
    }

    @IBAction func b2(sender: AnyObject) {
        bar1.setValues(v2, animated: animate)
        bar2.setValues(t2, animated: animate)
    }
    @IBAction func b3(sender: AnyObject) {
        bar1.setValues(v3, animated: animate)
        bar2.setValues(t3, animated: animate)
    }
}


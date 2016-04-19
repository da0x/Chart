//
//  ViewController.swift
//  CompoundBarChart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bar1: CompoundBarChartView!
    @IBOutlet weak var bar2: CompoundBarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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


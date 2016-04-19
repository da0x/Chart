//
//  CompoundBarChartView.swift
//  CompoundBarChart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit


@IBDesignable class CompoundBarChartView : UIView {
    
    @IBInspectable var v1 : CGFloat = CGFloat(100)
    @IBInspectable var C1 : UIColor = UIColor.blueColor()
    @IBInspectable var v2 : CGFloat  = CGFloat(100)
    @IBInspectable var C2 : UIColor = UIColor.greenColor()
    @IBInspectable var v3 : CGFloat  = CGFloat(100)
    @IBInspectable var C3 : UIColor = UIColor.orangeColor()
    @IBInspectable var v4 : CGFloat  = CGFloat(100)
    @IBInspectable var C4 : UIColor = UIColor.grayColor()
    @IBInspectable var v5 : CGFloat  = CGFloat(100)
    @IBInspectable var C5 : UIColor = UIColor.magentaColor()
    
    @IBInspectable var seperator = CGFloat(4)
    
    override func drawRect(rect: CGRect) {
         super.drawRect(rect)
    
        let calculator = CompoundBarChartCalculator(
            Values: [
                Double(v1),
                Double(v2),
                Double(v3),
                Double(v4),
                Double(v5)
            ],
            Height: Double(rect.size.height),
            Seperator: Double(seperator)
            )
        
        let colors = [C1,C2,C3,C4,C5]
        
        let x0 = Double(0)
        let x1 = Double(rect.size.width)
        
        for (index,bar) in calculator.bars().enumerate() {
            let path = UIBezierPath()
            
            path.moveToPoint(   CGPoint(x: x0,       y: bar.start))
            path.addLineToPoint(CGPoint(x: x1,       y: bar.start))
            path.addLineToPoint(CGPoint(x: x1,       y: bar.end))
            path.addLineToPoint(CGPoint(x: x0,       y: bar.end))
            
            colors[index].setFill()
            path.fill()
        }
        
    }
}
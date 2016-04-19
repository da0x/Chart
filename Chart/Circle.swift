//
//  CircleChartView.swift
//  Circle
//
//  Created by Daher Alfawares on 1/12/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class Circle : UIView {
    let π = CGFloat(M_PI)
    
    var userColors : Array<UIColor>!
    var userData   : Array<Double>! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        let data   = getData()
        let colors = getColors()
        
        let calculator =
            CircleCalculator(
                Data: data,
                StartAngle:Double(startAngle),
                SpaceAngle:Double(spaceAngle)
        )
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius : CGFloat = min(bounds.width, bounds.height)/2
        for arc in calculator.arcs() {
            
            let path =
            UIBezierPath(
                arcCenter:  center,
                radius:     radius - (arcWidth/2),
                startAngle: CGFloat(arc.start()),
                endAngle:   CGFloat(arc.end()),
                clockwise:  true)
            
            path.lineWidth = arcWidth
            colors[arc.index()%colors.count].setStroke()
            path.stroke()
        }
    }
    
    func getData()->Array<Double> {
        
        if let _ = userData {
            return userData
        }
        
        return [
            Double(data_1),
            Double(data_2),
            Double(data_3),
            Double(data_4),
            Double(data_5),
            Double(data_6)]
    }
    
    func getColors()->Array<UIColor> {
        if let _ = userColors {
            return userColors
        }
        
        return [
            color_1,
            color_2,
            color_3,
            color_4,
            color_5,
            color_6]
        
        
    }
    
    @IBInspectable var arcWidth     : CGFloat = 20
    @IBInspectable var startAngle   : CGFloat = 0
    @IBInspectable var spaceAngle   : CGFloat = 2
    
    @IBInspectable var color_1      : UIColor = UIColor.redColor()
    @IBInspectable var color_2      : UIColor = UIColor.greenColor()
    @IBInspectable var color_3      : UIColor = UIColor.blueColor()
    @IBInspectable var color_4      : UIColor = UIColor.purpleColor()
    @IBInspectable var color_5      : UIColor = UIColor.cyanColor()
    @IBInspectable var color_6      : UIColor = UIColor.orangeColor()
    
    @IBInspectable var data_1       : CGFloat = 100
    @IBInspectable var data_2       : CGFloat = 200
    @IBInspectable var data_3       : CGFloat = 150
    @IBInspectable var data_4       : CGFloat = 100
    @IBInspectable var data_5       : CGFloat = 200
    @IBInspectable var data_6       : CGFloat = 150
}






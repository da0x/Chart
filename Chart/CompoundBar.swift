//
//  CompoundBar.swift
//  Chart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit


@IBDesignable class CompoundBar : UIView {
    
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
    @IBInspectable var seperator = CGFloat(2)
    
    
    override func drawRect(rect: CGRect) {
         super.drawRect(rect)
        
        if (current == nil) {
            current = [Double(v1),Double(v2),Double(v3),Double(v4),Double(v5)]
        }
    
        let calculator = CompoundBarChartCalculator(
            Values: current!,
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
            
            colors[index%colors.count].setFill()
            path.fill()
        }
        
    }
    
    
    // Animations
    private var current : [Double]?
    private var target  : [Double]?
    private var displayLink : CADisplayLink!
    private var original    : [Double]?
    private var startTime   : NSTimeInterval = 0
    private var duration    : NSTimeInterval = 2
    
    func setValues(values:[Double], animated:Bool){
        if animated, let _ = current {
            original = current!
            target   = values
            
            while current?.count < target?.count {
                current?.append(0)
            }
            
            displayLink = CADisplayLink(target: self, selector: #selector(CompoundBar.animate))
            displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            startTime = 0
        } else {
            current = values
        }
        setNeedsDisplay()
    }
    
    func animate(){
        guard startTime > 0 else {
            startTime = displayLink.timestamp
            return
        }
        
        let t1 = self.startTime
        let t2 = displayLink.timestamp
        let dt = t2 - t1
        
        if dt > duration {
            displayLink?.invalidate()
            return
        }
        
        let r = Double( dt / duration )
        var c = [Double]()
        
        for (i,_) in target!.enumerate() {
            let Ci = current?[i] ?? 0
            let Ti = target![i]
            
            let Vi = Ci + r * ( Ti - Ci )
            c.append(Vi)
        }
        
        current = c
        setNeedsDisplay()
    }
}
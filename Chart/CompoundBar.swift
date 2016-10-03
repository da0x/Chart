//
//  CompoundBar.swift
//  Chart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}



@IBDesignable class CompoundBar : UIView {
    
    @IBInspectable var v1 : CGFloat = CGFloat(100)
    @IBInspectable var C1 : UIColor = UIColor.blue
    @IBInspectable var v2 : CGFloat  = CGFloat(100)
    @IBInspectable var C2 : UIColor = UIColor.green
    @IBInspectable var v3 : CGFloat  = CGFloat(100)
    @IBInspectable var C3 : UIColor = UIColor.orange
    @IBInspectable var v4 : CGFloat  = CGFloat(100)
    @IBInspectable var C4 : UIColor = UIColor.gray
    @IBInspectable var v5 : CGFloat  = CGFloat(100)
    @IBInspectable var C5 : UIColor = UIColor.magenta
    @IBInspectable var seperator = CGFloat(2)


    override func draw(_ rect: CGRect) {
         super.draw(rect)

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
        
        for (index,bar) in calculator.bars().enumerated() {
            let path = UIBezierPath()
            
            path.move(   to: CGPoint(x: x0,       y: bar.start))
            path.addLine(to: CGPoint(x: x1,       y: bar.start))
            path.addLine(to: CGPoint(x: x1,       y: bar.end))
            path.addLine(to: CGPoint(x: x0,       y: bar.end))
            
            colors[index%colors.count].setFill()
            path.fill()
        }
        
    }
    
    
    // Animations
    fileprivate var current : [Double]?
    fileprivate var target  : [Double]?
    fileprivate var displayLink : CADisplayLink!
    fileprivate var original    : [Double]?
    fileprivate var startTime   : TimeInterval = 0
    fileprivate var duration    : TimeInterval = 2
    
    func setValues(_ values:[Double], animated:Bool){
        if animated, let _ = current {
            original = current!
            target   = values
            
            while current?.count < target?.count {
                current?.append(0)
            }
            
            displayLink = CADisplayLink(target: self, selector: #selector(CompoundBar.animateMe))
            displayLink.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            startTime = 0
        } else {
            current = values
        }
        setNeedsDisplay()
    }
    
    func animateMe(){
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
        
        for (i,_) in target!.enumerated() {
            let Ci = current?[i] ?? 0
            let Ti = target![i]
            
            let Vi = Ci + r * ( Ti - Ci )
            c.append(Vi)
        }
        
        current = c
        setNeedsDisplay()
    }
}


//
//  AreaChart.swift
//  Chart
//
//  Created by Daher Alfawares on 5/9/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit

@IBDesignable class Line : UIView {
    
    // area view model
    class Model {
        var values : [Double]
        
        init( values : [Double] ){
            self.values = values
        }
    }
    
    class Calculator {
        
        private var values  : [Double]
        private var maximum : Double = 0
        private var minimum : Double = 999999999999
        
        init(values : [Double]){
            self.values = values
            
            //create the maximum.
            for value in values {
                
                // maximum
                if maximum < value {
                    maximum = value
                }
                
                if minimum > value {
                    minimum = value
                }
            }
            
            
            //...
            
        }
        
        func norms() -> [Double] {
            var norms : [Double] = []

            // each value
            for (_,value) in values.reversed().enumerated() {
                
                // set value
                norms.append((value-minimum)/(maximum-minimum))
            }

            return norms
        }
    }
    
    @IBInspectable var fillColor : UIColor = UIColor.black()
    @IBInspectable var strokeColor : UIColor = UIColor.black()
    
    override func draw(_ rect: CGRect) {
        
        guard let current = current else { return }
        fillColor.setFill()
        strokeColor.setStroke()
        
        let calculator = Calculator(values: current)
        let norms = calculator.norms()
        
       
        let width  = Double(rect.size.width )
        let height = Double(rect.size.height)
        
        // create path
        let path = UIBezierPath()
        // reset path position
        path.move(to: CGPoint(x: 0, y: Double(rect.size.height)))
        
        for (i,value) in norms.enumerated() {

            let x = width  * Double(i) / Double(norms.count-1)
            let y = height - Double(rect.size.height) * value
            
            path.addLine(to: CGPoint(x:x,y:y))
        }
        
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        path.close()
        path.fill()
        path.stroke()
    }
    
    private let threshold = Double(0.05)
    
    
    
    // Animations
    private var currentLimit   : Int = 10
    private var targetLimit    : Int = 0
    private var originalLimit  : Int = 0
    
    private var current : [Double]?
    private var target  : [Double]?
    
    private var original    : [Double]?
    private var displayLink : CADisplayLink!
    private var startTime   : TimeInterval = 0
    private var duration    : TimeInterval = 0.5
    
    func setValues(_ values:[Double], animated:Bool, limit: Int){
        if animated, let _ = current {
            original = current!
            originalLimit = currentLimit
            
            target   = values
            targetLimit = limit
            
            displayLink = CADisplayLink(target: self, selector: #selector(CompoundBar.animateMe))
            displayLink.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            startTime = 0
        } else {
            current = values
            currentLimit = limit
        }
        setNeedsDisplay()
    }
    
    func animateMe(){
        if startTime == 0 {
            startTime = displayLink.timestamp
            return
        }
        
        let t1 = self.startTime
        let t2 = displayLink.timestamp
        var dt = t2 - t1
        
        if dt > duration {
            displayLink?.invalidate()
            
            // get a final accurate frame.
            dt = duration
        }
        
        let r = Double( dt / duration )
        var c = [Double]()
        
        
        let Cil = Double(originalLimit)
        let Til = Double(targetLimit)
        
        let Vi = Cil + r * ( Til - Cil )
        currentLimit = Int(Vi)
        
        for (i,_) in target!.enumerated() {
            
            if i > currentLimit {
                break
            }
            
            if i >= current?.count {
                current?.append(target![i])
            }
            
            let Ci = current?[i] ?? 0
            let Ti = target![i]
            
            let Vi = Ci + r * ( Ti - Ci )
            c.append(Vi)
        }
        
        current = c
        setNeedsDisplay()
    }
}



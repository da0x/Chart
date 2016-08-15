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
        var values : [Quote]
        
        init( values : [Quote] ){
            self.values = values
        }
    }
    
    class Calculator {
        
        private var values  : [Quote]
        private var maximum : Double = 0
        private var minimum : Double = 999999999999
        private var start   : Date
        
        init(values : [Quote], start : Date){
            self.values = values
            self.start  = start
            
            //create the maximum.
            for value in values {
                
                if value.Date.timeIntervalSince(start) < 0 {
                    continue
                }
                
                // maximum
                if maximum < value.Close {
                    maximum = value.Close
                }
                
                if minimum > value.Close {
                    minimum = value.Close
                }
            }
            
            //...
        }
        
        func norms() -> [Double] {
            var norms : [Double] = []

            // each value
            for (_,value) in values.enumerated() {
                
                if value.Date.timeIntervalSince(start) < 0 {
                    continue
                }
                
                // set value
                norms.append((value.Close-minimum)/(maximum-minimum))
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
        
        let calculator = Calculator(values: current, start: currentLimit)
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
    private var currentLimit   : Date = Date()
    private var targetLimit    : Date = Date()
    private var originalLimit  : Date = Date()
    
    private var current        : [Quote]?
    private var displayLink    : CADisplayLink!
    private var startTime      : TimeInterval = 0
    private var duration       : TimeInterval = 1
    
    func setValues(_ values:[Quote], animated:Bool, startFrom: Date){
        if animated, let _ = current {
            originalLimit   = currentLimit
            targetLimit     = startFrom
            displayLink     = CADisplayLink(target: self, selector: #selector(Line.animateMe))
            startTime       = 0
            
            displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            
        } else {
            current         = values
            currentLimit    = startFrom
        }

        setNeedsDisplay()
    }
    
    func animateMe(){
        guard let _ = displayLink else { return }
        
        if startTime == 0 {
            startTime = (displayLink?.timestamp)!
            return
        }

        let t1 = self.startTime
        let t2 = displayLink.timestamp
        var dt = t2 - t1

        if dt > duration {
            displayLink?.invalidate()
            displayLink?.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            displayLink = nil
            
            // get a final accurate frame.
            dt = duration
        }

        let r = Double( dt / duration )

        let Cil = Double(originalLimit.timeIntervalSince1970)
        let Til = Double(targetLimit.timeIntervalSince1970)

        let Vi = Cil + r * ( Til - Cil )
        currentLimit = Date(timeIntervalSince1970: TimeInterval(Vi))

        setNeedsDisplay()
    }
}



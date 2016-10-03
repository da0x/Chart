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
    
    class RangeCalculator {
        
        fileprivate var values  : [Quote]
        fileprivate var maximum : Double = 0
        fileprivate var minimum : Double = 999999999999
        fileprivate var start   : Date
        
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
        }
        
        func min()->Double { return minimum }
        func max()->Double { return maximum }
    }
    
    class Calculator {
        
        fileprivate var values  : [Quote]
        fileprivate var maximum : Double
        fileprivate var minimum : Double
        fileprivate var start   : Date
        
        init(values : [Quote], start : Date, min : Double, max : Double ){
            self.values  = values
            self.start   = start
            self.minimum = min
            self.maximum = max
        }
        
        func norms() -> [Double] {
            var norms : [Double] = []

            // each value
            for (_,value) in values.enumerated() {
                
                if value.Date.timeIntervalSince(start) < 0 {
                    continue
                }
                
                let y = (value.Close-minimum)/(maximum-minimum)
                
                let p = 0.2
                let y1 = (y * (1-2*p) ) + p
                
                // set value
                norms.append(y1)
            }
            
            return norms
        }
    }
    
    @IBInspectable var fillColor   : UIColor = UIColor.black
    @IBInspectable var strokeColor : UIColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        
        guard let current = current else { return }
        fillColor.setFill()
        strokeColor.setStroke()
        
        let calculator = Calculator(values: current, start: start, min: minimum, max: maximum)
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
    
    class AnimationCurve {
        fileprivate let π = M_PI
        fileprivate var target : Double
        fileprivate var origin : Double
        
        init( origin: Double, target: Double ){
            self.origin = origin
            self.target = target
        }
        
        func linear(_ dt:Double, duration:Double) -> Double {
            var r = Double( dt / duration )
            
            if r > 1 { r = 1 }
            if r < 0 { r = 0 }
            
            let Oi = Double(origin)
            let Ti = Double(target)
            
            let Vi = Oi + r * ( Ti - Oi )
        
            return Vi
        }
        
        func easeIn(_ dt:Double, duration:Double) -> Double {
            
            let x = Double( dt / duration )
            let θ = x * π * 0.5
            var r = sin(θ)
            
            if r > 1 { r = 1 }
            if r < 0 { r = 0 }
            
            let Oi = Double(origin)
            let Ti = Double(target)
            
            let Vi = Oi + r * ( Ti - Oi )
            
            return Vi
        }
        
        func easeInOut(_ dt:Double, duration:Double) -> Double {
            
            let x = Double( dt / duration )
            let θ = x * π - π * 0.5
            var r = ( sin(θ) + 1.0 ) / 2.0
            
            if r > 1 { r = 1 }
            if r < 0 { r = 0 }
            
            let Oi = Double(origin)
            let Ti = Double(target)
            
            let Vi = Oi + r * ( Ti - Oi )
            
            return Vi
        }
    }
    
    // Animations
    fileprivate var current             : [Quote]?
    fileprivate var start               : Date = Date()
    fileprivate var minimum             : Double = 0
    fileprivate var maximum             : Double = 0
    
    fileprivate var minAnimationCurve   : AnimationCurve!
    fileprivate var maxAnimationCurve   : AnimationCurve!
    fileprivate var startAnimationCurve : AnimationCurve!
    
    fileprivate var displayLink    : CADisplayLink!
    fileprivate var startTime      : TimeInterval = 0
    fileprivate var duration       : TimeInterval = 1
    
    func setValues(_ values:[Quote], animated:Bool, startFrom: Date){
        if animated, let _ = current {
            
            startAnimationCurve = AnimationCurve(origin: start.timeIntervalSince1970, target: startFrom.timeIntervalSince1970)
            minAnimationCurve   = AnimationCurve(origin: minimum, target: RangeCalculator(values: current!, start: startFrom).min())
            maxAnimationCurve   = AnimationCurve(origin: maximum, target: RangeCalculator(values: current!, start: startFrom).max())
            
            displayLink     = CADisplayLink(target: self, selector: #selector(Line.animateMe))
            startTime       = 0
            
            displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            
        } else {
            current   = values
            start     = startFrom
            minimum   = RangeCalculator(values: current!, start: startFrom).min()
            maximum   = RangeCalculator(values: current!, start: startFrom).max()
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

        let s = startAnimationCurve.easeInOut(dt, duration: duration)
        let m =   minAnimationCurve.easeInOut(dt, duration: duration)
        let x =   maxAnimationCurve.easeInOut(dt, duration: duration)
        
        start   = Date(timeIntervalSince1970: s)
        minimum = m
        maximum = x

        setNeedsDisplay()
    }
}



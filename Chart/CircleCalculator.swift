//
//  CircleCalculator.swift
//  Circle
//
//  Created by Daher Alfawares on 1/13/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import Foundation
import UIKit


class CircleCalculator {
    let π = Double(M_PI)
    
    var data       : Array<Double>
    var spaceAngle : Double
    var startAngle : Double
    
    init(Data : Array<Double>, StartAngle : Double, SpaceAngle : Double){
        data        = Data
        spaceAngle  = SpaceAngle
        startAngle  = StartAngle
    }
    

    func count()->Double {
        var filteredCount : Double = 0
        for item in data {
            if item > 0 {
                filteredCount += 1
            }
        }
        
        return filteredCount
    }
    
    func space()->Double {
        if data.count <= 1 {
            return 0
        }
        
        return π * spaceAngle / 180
    }
    
    func totalSpace()->Double {
        return space() * count()
    }
    
    func start()->Double {
        return π * startAngle / 180
    }
    
    func totalAngle()->Double {
        return 2 * π - totalSpace()
    }
    
    func arcs()->Array<Arc> {
        
        var arcs    = Array<Arc>()
        let total   = self.total()
        var angle : Double = start()
        
        for (i,element) in data.enumerated() {
            
            if element <= 0 {
                continue
            }
            
            let normal     = totalAngle() * element / total
            let startAngle = angle
            let endAngle   = angle + normal
            
            angle += normal
            angle += space()
            
            arcs.append(
                Arc(
                    index       : i,
                    startAngle  : startAngle,
                    endAngle    : endAngle
                )
            )
        }
        
        return arcs
    }
    
    func total()->Double {
        var total : Double = 0
        for i in data {
            total += i
        }
        
        return total
    }
    
        // innter class, defines an arc
    class Arc {
        private var a1 : Double
        private var a2 : Double
        private var i  : Int
        
        init(index:Int, startAngle:Double, endAngle:Double){
            i    = index
            a1   = startAngle
            a2   = endAngle
        }
        func start()->Double {
            return a1
        }
        func end()->Double {
            return a2
        }
        
        func index()->Int {
            return i
        }
    }
}


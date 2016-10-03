//
//  CompoundBarCalculator.swift
//  Chart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import Foundation

class CompoundBarChartCalculator {
    
    
    class Bar {
        var start = Double(0)
        var end   = Double(1)
    }
    
    fileprivate var values          : [Double]!
    fileprivate var height          : Double!
    fileprivate var total           : Double!
    fileprivate var seperator       : Double!
    
    init( Values : [Double], Height : Double, Seperator : Double){
        values         = Values
        height         = Height
        total          = sum(Values)
        seperator      = Seperator
    }
    
    func bars() -> [Bar]{
        
        var bars = [Bar]()
        var accumilation = Double(0)

        let C = Double(values.count)
        let S = seperator
        let H = height
        let Sum = total

        for v in values {

                // create a bar
            let bar = Bar()

            let Vi = v
            let Ni = Vi / Sum!
            let Li = Ni * ( H! - ( S! * ( C - 1 ) ) )

            bar.start = accumilation
            bar.end   = accumilation + Li

            bars.append(bar)

                // set accumilation for next bar
            accumilation = accumilation + Li + seperator
        }
        return bars
    }

    func sum(_ values:[Double]) -> Double {
        var T = Double(0)
        for value in values {
            T += value
        }
        return T
    }
}

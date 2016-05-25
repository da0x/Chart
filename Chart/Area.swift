//
//  AreaChart.swift
//  Chart
//
//  Created by Daher Alfawares on 5/9/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit

@IBDesignable class Area : UIView {
    
    // area view model
    class Model {
        let rows : [Element]
        let back : [Element]
        
        init( Back : [Element], Rows : [Element] ){
            rows = Rows
            back = Back
        }
    }
    
    class Element {
        let color  : UIColor
        let values : [Double]
        
        init(Values:[Double],Color:UIColor){
            values = Values
            color  = Color
        }
    }
    
    class Calculator {
        
        class Graph {
            internal var norms  : [Double] = []
            internal var color  : UIColor
            
            init(Norms:[Double], Color:UIColor){
                norms = Norms
                color = Color
            }
        }
        
        var backRows : [Graph] = []
        var rows     : [Graph] = []
        
        init(model : Model){
            blad()
            
            create the maximum based on the incremental values.
            
            var maximum : Double = 0
            var values  = [Double]()
            
            // loop over paths
            for element in model.back {
                
                // each value
                for (_,value) in element.values.enumerate() {
                    
                    // maximum
                    if maximum < value {
                        maximum = value
                    }
                }
            }
            for element in model.rows {
                
                // each value
                for (_,value) in element.values.enumerate() {
                    
                    // maximum
                    if maximum < value {
                        maximum = value
                    }
                }
            }
            
            // reduce above
            
            
            var norms : [Double] = []
            
            for element in model.rows {
                // each value
                
                for (i,value) in element.values.enumerate() {
                    
                    // safe-range
                    if( norms.count <= i ){ norms.append(0) }
                    
                    // set value
                    norms[i] = norms[i] + value/maximum
                    
                }
                
                rows.append(Graph(Norms: norms, Color: element.color))
            }
        }
    }
    
    var model : Model = Model(Back: [], Rows: [])
    
    override func drawRect(rect: CGRect) {
        
        let calculator = Calculator(model: model)
        
        for graph in calculator.backRows {
            drawGraphInRect(rect, graph: graph)
        }
        
            // loop over paths in reverse and render
        for graph in calculator.rows.reverse() {
            
            drawGraphInRect(rect,graph: graph)
        }
    }
    
    func drawGraphInRect(rect:CGRect,graph:Calculator.Graph){
        
        let width  = Double(rect.size.width )
        let height = Double(rect.size.height)
        
        // create path
        let path = UIBezierPath()
        
        // reset path position
        path.moveToPoint(CGPoint(x: 0, y: Double(rect.size.height)))
        
        for (i,value) in graph.norms.enumerate() {

            let x = width  * Double(i) / Double(graph.norms.count-1)
            let y = height - Double(rect.size.height) * value
            
            
            if i > 0 {
                let previousValue = graph.norms[i-1]
                var diff = value - previousValue
                
                if diff < 0 {
                    diff = -diff
                }
                if diff > threshold {
                    let y0 = height - height * previousValue
                    
                    path.addLineToPoint(CGPoint(x:x,y:y0))
                }
            }
            
            path.addLineToPoint(CGPoint(x:x,y:y))
        }
        
        path.addLineToPoint(CGPoint(x: rect.size.width, y: rect.size.height))
        path.closePath()
        
        graph.color.setFill()
        path.fill()
    }
    
    private let threshold = Double(0.05)
}


//
//  CompoundBarCalculatorTests.swift
//  Chart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import XCTest
@testable import CompoundBarChart


class CompoundBarChartCalculatorTests: XCTestCase {
    
    typealias Calculator = CompoundBarChartCalculator
    
    override func setUp() {
    }
    
    
    func testZeroValues(){
        let o = Calculator(Values: [], Height: 0, Seperator: 0)
        
        XCTAssertEqual(o.bars().count, 0)
    }
    
    func testOneValue(){
        let o = Calculator(Values:[10], Height: 10, Seperator: 0)
        
        XCTAssertEqual(o.bars().count, 1)
        
        if let bar = o.bars().first {
            XCTAssertEqual(bar.start, 0)
            XCTAssertEqual(bar.end, 10)
        }
    }
    
    func testTwoBars(){
        let o = Calculator(Values: [1,1], Height: 10, Seperator: 0)
        
        XCTAssertEqual(o.bars().count, 2)
        
        if let bar1 = o.bars().first, let bar2 = o.bars().last {
            XCTAssertEqual(bar1.start, 0 )
            XCTAssertEqual(bar1.end,   5 )
            XCTAssertEqual(bar2.start, 5 )
            XCTAssertEqual(bar2.end,   10)
        }
    }
    
    func testFourBars(){
        let o = Calculator(Values: [1,1,1,1], Height: 100, Seperator: 0)
        
        XCTAssertEqual(o.bars().count, 4)
        
        let bars = o.bars()
        
        guard bars.count == 4 else { return }
        
        let bar1 = bars[0]
        let bar2 = bars[1]
        let bar3 = bars[2]
        let bar4 = bars[3]
            
        XCTAssertEqual(bar1.start, 0  )
        XCTAssertEqual(bar1.end,   25 )
        XCTAssertEqual(bar2.start, 25 )
        XCTAssertEqual(bar2.end,   50 )
        XCTAssertEqual(bar3.start, 50 )
        XCTAssertEqual(bar3.end,   75 )
        XCTAssertEqual(bar4.start, 75 )
        XCTAssertEqual(bar4.end,   100)
    }
    
    func testSeperator(){
        
        let o = Calculator(Values: [1,1], Height: 3, Seperator: 1)
        
        let bars = o.bars()
        guard bars.count == 2 else { return }
        
        let bar1 = bars[0]
        let bar2 = bars[1]
        
        XCTAssertEqual(bar1.start, 0)
        XCTAssertEqual(bar1.end,   1)
        XCTAssertEqual(bar2.start, 2)
        XCTAssertEqual(bar2.end,   3)
    }
    
    func testSeperatorComplex(){
        
        let o = Calculator(Values: [10,5,20,15], Height: 54, Seperator: 1)
        
        let bars = o.bars()
        guard bars.count == 2 else { return }
        
        let bar1 = bars[0]
        let bar2 = bars[1]
        let bar3 = bars[2]
        let bar4 = bars[3]
        
        XCTAssertEqual(bar1.start, 0 )
        XCTAssertEqual(bar1.end,   10)
        XCTAssertEqual(bar2.start, 11)
        XCTAssertEqual(bar2.end,   17)
        XCTAssertEqual(bar3.start, 18)
        XCTAssertEqual(bar3.end,   39)
        XCTAssertEqual(bar4.start, 40)
        XCTAssertEqual(bar4.end,   54)
    }
    
    
}

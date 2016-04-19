//
//  CircleChartTests.swift
//  CircleTests
//
//  Created by Daher Alfawares on 1/12/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import XCTest
@testable import Chart

class CircleTests: XCTestCase {
    typealias O = CircleCalculator
    
    var chart : O!
    
    override func setUp() {
        super.setUp()
    }
    
    func testSpacingIsZeroForOneItem() {
        
        chart = O(Data: [300], StartAngle: 0, SpaceAngle: 10)
        
        XCTAssertEqual(chart.space(), 0)
        XCTAssertEqual(chart.totalSpace(), 0)
    }
    
    func testAnglesInRadian() {
        chart = O(Data: [300,300], StartAngle: 180, SpaceAngle: 90)
        
        
        XCTAssertEqual(chart.start(), chart.π)
        XCTAssertEqual(chart.space(), chart.π / 2.0)
    }
    
    func testFirstItemStartsAtStartAngle(){
        
        chart = O(Data: [300,300], StartAngle: 30, SpaceAngle: 10)
        
        XCTAssertEqual(chart.start(), 30 * chart.π / 180)
    }
    
    func testArcsAreEqual(){
        chart = O(Data: [100,100], StartAngle: 0, SpaceAngle: 0)
        
        let arc1 = chart.arcs()[0]
        let arc2 = chart.arcs()[1]
        
        XCTAssertEqual(arc1.start(), 0)
        XCTAssertEqual(arc1.end(), chart.π)
        XCTAssertEqual(arc2.start(), chart.π)
        XCTAssertEqual(arc2.end(), 2*chart.π)
    }
    
    func testCount(){
        chart = O(Data: [100,200], StartAngle: 0, SpaceAngle: 0)
        
        XCTAssertEqual(chart.count(), 2)
    }
    
    func testCountSkipsEmpty(){
        chart = O(Data: [100,0,12], StartAngle: 0, SpaceAngle: 0)
        
        XCTAssertEqual(chart.count(), 2)
    }
    
    func testSpaceExcludesEmpty(){
        chart = O(Data: [100,0,100], StartAngle: 0, SpaceAngle: 90)
        
        XCTAssertEqual(chart.totalSpace(), chart.π)
    }
    
    func testArcsExcludesEmpty(){
        
        chart = O(Data: [100,0,100], StartAngle: 0, SpaceAngle: 0)
        
        XCTAssertEqual(chart.arcs().count, 2)
    }
    
    func testArcIndexMatchesColor() {
        chart = O(Data: [100,0,100], StartAngle: 0, SpaceAngle: 0)
        
        let arc1 = chart.arcs()[1]
        XCTAssertEqual(arc1.index(), 2)
    }
}

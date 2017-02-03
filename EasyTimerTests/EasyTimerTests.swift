//
//  EasyTimerTests.swift
//  EasyTimerTests
//
//  Created by Niklas Fahl on 3/2/16.
//  Copyright © 2016 High Bay. All rights reserved.
//

import XCTest
@testable import EasyTimer

class EasyTimerTests: XCTestCase {
    
    // MARK: Set up/Tear Down
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Timer Creation
    func testTimerCreation() {
        let timer = 3.minute.timer(repeats: true, delays: true) {
            // ...
        }
        XCTAssertTrue(timer.isValid)
    }
    
    func testTimerCreationPassingTimerInBlock() {
        let timer = 3.minute.timer(repeats: true, delays: true) { (timer: Timer) -> Void in
            // ...
        }
        XCTAssertTrue(timer.isValid)
    }
    
    // MARK: - Time Interval
    // Doubles
    func testDoubleMillisecondTimeIntervals() {
        XCTAssertEqual(2.0.millisecond, 0.002)
    }
    
    func testDoubleSecondTimeIntervals() {
        XCTAssertEqual(3.0.second, 3.0)
    }
    
    func testDoubleMinuteTimeIntervals() {
        XCTAssertEqual(4.0.minute, 240.0)
    }
    
    func testDoubleHourTimeIntervals() {
        XCTAssertEqual(5.0.hour, 18000.0)
    }
    
    func testDoubleDayTimeIntervals() {
        XCTAssertEqual(6.0.day, 518400.0)
    }
    
    // Ints
    func testIntMillisecondTimeIntervals() {
        XCTAssertEqual(2.millisecond, 0.002)
    }
    
    func testIntSecondTimeIntervals() {
        XCTAssertEqual(3.second, 3.0)
    }
    
    func testIntMinuteTimeIntervals() {
        XCTAssertEqual(4.minute, 240.0)
    }
    
    func testIntHourTimeIntervals() {
        XCTAssertEqual(5.hour, 18000.0)
    }
    
    func testIntDayTimeIntervals() {
        XCTAssertEqual(6.day, 518400.0)
    }
    
    // MARK: - Starting/Stopping Timer
    func testStartNotRepeatingNotDelayingTimer() {
        let expectation = self.expectation(description: "testStartNotRepeatingNotDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: false) { 
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(0 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectations(timeout: 0.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingNotDelayingTimer() {
        let expectation = self.expectation(description: "testStartRepeatingNotDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: false) {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectations(timeout: 3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartNotRepeatingDelayingTimer() {
        let expectation = self.expectation(description: "testStartNotRepeatingDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: true) {
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(3 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectations(timeout: 3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingDelayingTimer() {
        let expectation = self.expectation(description: "testStartRepeatingDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: true) {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectations(timeout: 6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartNotRepeatingNotDelayingTimerPassingTimerInBlock() {
        let expectation = self.expectation(description: "testStartNotRepeatingNotDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: false) { (timer: Timer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(0 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectations(timeout: 0.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingNotDelayingTimerPassingTimerInBlock() {
        let expectation = self.expectation(description: "testStartRepeatingNotDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: false) { (timer: Timer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectations(timeout: 3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartNotRepeatingDelayingTimerPassingTimerInBlock() {
        let expectation = self.expectation(description: "testStartNotRepeatingDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: true) { (timer: Timer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(3 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectations(timeout: 3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingDelayingTimerPassingTimerInBlock() {
        let expectation = self.expectation(description: "testStartRepeatingDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: true) { (timer: Timer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectations(timeout: 6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStoppingTimer() {
        let timer = 2.second.interval {
            // ...
        }
        timer.stop()
        XCTAssertFalse(timer.isValid)
    }
    
    // MARK: - Delay
    func testDelay() {
        let expectation = self.expectation(description: "testDelay")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let _ = 2.second.delay {
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let delayTolerance = abs(2 - delayTime)
            XCTAssertLessThan(delayTolerance, 0.02)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testDelayPassingTimerInBlock() {
        let expectation = self.expectation(description: "testDelayPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let _ = 5.second.delay { (timer: Timer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let delayTolerance = abs(5 - delayTime)
            XCTAssertLessThan(delayTolerance, 0.02)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTimerInDelayBlock() {
        let expectation = self.expectation(description: "testTimerInDelayBlock")
        
        let _ = 5.second.delay { (timer: Timer) -> Void in
            XCTAssertTrue(timer.isValid)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Interval
    func testInterval() {
        let expectation = self.expectation(description: "testInterval")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let _ = 3.second.interval {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testIntervalPassingTimerInBlock() {
        let expectation = self.expectation(description: "testIntervalPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let _ = 3.second.interval { (timer: Timer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTimerInIntervalBlock() {
        let expectation = self.expectation(description: "testTimerInIntervalBlock")
        
        let _ = 5.second.interval { (timer: Timer) -> Void in
            XCTAssertTrue(timer.isValid)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Delayed Interval
    func testDelayedInterval() {
        let expectation = self.expectation(description: "testDelayedInterval")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let _ = 3.second.delayedInterval {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testDelayedIntervalPassingTimerInBlock() {
        let expectation = self.expectation(description: "testDelayedIntervalPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let _ = 3.second.delayedInterval { (timer: Timer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count += 1
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTimerInDelayedIntervalBlock() {
        let expectation = self.expectation(description: "testTimerInDelayedIntervalBlock")
        
        let _ = 5.second.delayedInterval { (timer: Timer) -> Void in
            XCTAssertTrue(timer.isValid)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

//
//  FPSTests.swift
//  
//
//  Created by 史 翔新 on 2022/11/16.
//

import XCTest
@testable import TimeCodeCounterPackage

final class FPSTests: XCTestCase {

    func test_framesPerSecondOnTimeCode() throws {
        
        typealias TestCase = (line: UInt, fps: FPS, expected: Int)
        let testCases: [TestCase] = [
            (#line, .f59_94_ndf, 60),
        ]
        
        for testCase in testCases {
            XCTAssertEqual(testCase.fps.framesPerSecondOnTimeCode, testCase.expected, line: testCase.line)
        }
        
    }
    
    func test_framesPer10Minutes() {
        
        typealias TestCase = (line: UInt, fps: FPS, expected: Int)
        let testCases: [TestCase] = [
            (#line, .f59_94_ndf, 35964),
        ]
        
        for testCase in testCases {
            XCTAssertEqual(testCase.fps.framesPer10Minutes, testCase.expected, line: testCase.line)
        }
        
    }
    
    func test_frameCount() {
        
        typealias TestCase = (line: UInt, fps: FPS, elapsedTime: TimeInterval, expected: Int)
        let testCases: [TestCase] = [
            (#line, .f59_94_ndf,   0,        0),
            (#line, .f59_94_ndf,   1,       59),
            (#line, .f59_94_ndf,   1.01,    60),
            (#line, .f59_94_ndf,  60,     3596),
            (#line, .f59_94_ndf,  60.07,  3600),
            (#line, .f59_94_ndf, 600,    35964),
            (#line, .f59_94_ndf, 600.61, 36000),
        ]
        
        for testCase in testCases {
            XCTAssertEqual(testCase.fps.frameCount(during: testCase.elapsedTime), testCase.expected, line: testCase.line)
        }
        
    }
    
    func test_formattedTimeCodeFrameCount() {
        
        typealias TestCase = (line: UInt, fps: FPS, frameCount: Int, expected: String)
        let testCases: [TestCase] = [
            (#line, .f59_94_ndf,     0, "00:00:00:00"),
            (#line, .f59_94_ndf,    59, "00:00:00:59"),
            (#line, .f59_94_ndf,    60, "00:00:01:00"),
            (#line, .f59_94_ndf,  3539, "00:00:58:59"),
            (#line, .f59_94_ndf,  3540, "00:00:59:00"),
            (#line, .f59_94_ndf,  3600, "00:01:00:00"),
            (#line, .f59_94_ndf, 35964, "00:09:59:24"),
            (#line, .f59_94_ndf, 36000, "00:10:00:00"),
        ]
        
        for testCase in testCases {
            XCTAssertEqual(testCase.fps.formattedTimeCode(frameCount: testCase.frameCount), testCase.expected, line: testCase.line)
        }
        
    }
    
    func test_formattedTimeCodeDuring() {
        
        typealias TestCase = (line: UInt, fps: FPS, elapsedTime: TimeInterval, expected: String)
        let testCases: [TestCase] = [
            (#line, .f59_94_ndf,   0,    "00:00:00:00"),
            (#line, .f59_94_ndf,   1,    "00:00:00:59"),
            (#line, .f59_94_ndf,   1.01, "00:00:01:00"),
            (#line, .f59_94_ndf,  60,    "00:00:59:56"),
            (#line, .f59_94_ndf,  60.07, "00:01:00:00"),
            (#line, .f59_94_ndf,  61,    "00:01:00:56"),
            (#line, .f59_94_ndf, 600,    "00:09:59:24"),
            (#line, .f59_94_ndf, 600.61, "00:10:00:00"),
        ]
        
        for testCase in testCases {
            XCTAssertEqual(testCase.fps.formattedTimeCode(during: testCase.elapsedTime), testCase.expected, line: testCase.line)
        }
        
    }
    
}

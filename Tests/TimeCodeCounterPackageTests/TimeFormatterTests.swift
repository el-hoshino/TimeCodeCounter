//
//  TimeFormatterTests.swift
//
//
//  Created by 史 翔新 on 2022/11/16.
//

import XCTest
@testable import TimeCodeCounterPackage

final class TimeFormatterTests: XCTestCase {
    
    let timeFormatter = TimeFormatter()
    
    func test_string() throws {
        
        typealias TestCase = (line: UInt, seconds: Int, expected: String)
        let testCases: [TestCase] = [
            (#line, 0, "00:00:00"),
            (#line, 59, "00:00:59"),
            (#line, 60, "00:01:00"),
            (#line, 61, "00:01:01"),
            (#line, 3599, "00:59:59"),
            (#line, 3600, "01:00:00"),
            (#line, 3601, "01:00:01"),
            (#line, 3661, "01:01:01"),
        ]
        
        for testCase in testCases {
            XCTAssertEqual(timeFormatter.string(seconds: testCase.seconds), testCase.expected, line: testCase.line)
        }
    }
    
}

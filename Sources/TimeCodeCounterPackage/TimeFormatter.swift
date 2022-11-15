//
//  File.swift
//  
//
//  Created by 史 翔新 on 2022/11/16.
//

import Foundation

struct TimeFormatter {
    
    func string(seconds: Int) -> String {
        let ss = seconds % secondsPerMinute
        let mm = seconds / secondsPerMinute % minutesPerHour
        let hh = seconds / secondsPerMinute / minutesPerHour % hoursPerDay
        let formatted = [hh, mm, ss]
            .map { $0.formatted(digits: 2) }
            .joined(separator: ":")
        return formatted
    }
    
}

private var secondsPerMinute: Int {
    60
}

private var minutesPerHour: Int {
    60
}

private var hoursPerDay: Int {
    24
}


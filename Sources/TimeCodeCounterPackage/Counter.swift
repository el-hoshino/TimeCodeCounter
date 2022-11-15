//
//  Counter.swift
//
//
//  Created by 史 翔新 on 2022/11/16.
//

import Combine
import Foundation

@MainActor
public final class Counter: ObservableObject {
    
    private var startDate: Date?
    @Published private(set) var currentDate: Date?
    @Published private var timer: Timer? = nil
    
    private let timeFormatter: TimeFormatter = .init()
    
    public init() {}
    
    public var elapsedTime: TimeInterval? {
        guard let startDate, let currentDate else {
            return nil
        }
        return currentDate.timeIntervalSince(startDate)
    }
    
    public var isRunning: Bool {
        timer?.isValid ?? false
    }
    
    public var elapsedTimeString: String {
        guard let elapsedTime else {
            return "n/a"
        }
        let multiplier: TimeInterval = 1000
        let rounded = (elapsedTime * multiplier).rounded() / multiplier
        let sss = Int(rounded * multiplier) % Int(multiplier)
        let firstPart = timeFormatter.string(seconds: Int(rounded))
        let secondPart = sss.formatted(digits: 3)
        return "\(firstPart).\(secondPart)"
    }
    
    public func reset() {
        timer?.invalidate()
        timer = nil
        startDate = nil
        currentDate = nil
    }
    
    public func start(from date: Date? = nil) {
        guard !isRunning else {
            return
        }
        startDate = date ?? Date()
        currentDate = startDate
        timer = Timer.scheduledTimer(
            timeInterval: 1 / 240,
            target: self,
            selector: #selector(updateCurrentDate),
            userInfo: nil, repeats: true
        )
    }
    
    public func stop() {
        guard isRunning else { return }
        timer?.invalidate()
        updateCurrentDate()
    }
    
    @objc private func updateCurrentDate() {
        currentDate = Date()
    }
    
    public func frameCount(under fps: FPS) -> Int {
        guard let elapsedTime else {
            return 0
        }
        return fps.frameCount(during: elapsedTime)
    }
    
    public func timeCode(under fps: FPS) -> String {
        guard let elapsedTime else {
            return "n/a"
        }
        return fps.formattedTimeCode(during: elapsedTime)
    }
    
}
